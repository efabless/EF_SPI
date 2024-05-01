from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info, uvm_error, uvm_warning
from uvm.comps.uvm_monitor import UVMMonitor
from uvm.tlm1.uvm_analysis_port import UVMAnalysisPort
from uvm.base.uvm_config_db import UVMConfigDb
from cocotb.triggers import (
    Timer,
    ClockCycles,
    FallingEdge,
    Event,
    RisingEdge,
    Combine,
    First,
)
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW, UVM_MEDIUM
import cocotb
import math
from EF_UVM.ip_env.ip_agent.ip_monitor import ip_monitor
from spi_item.spi_item import spi_item


class spi_monitor(ip_monitor):
    def __init__(self, name="spi_monitor", parent=None):
        super().__init__(name, parent)
        self.config_phase_finish_event = Event()
        self.start_new_tr_event = Event()
        self.cpol_val = 0
        self.cpha_val = 0

    def build_phase(self, phase):
        super().build_phase(phase)
        # get data width
        arr = []
        if not UVMConfigDb.get(self, "", "DATA_WIDTH", arr):
            self.data_width = 8
        else:
            self.data_width = arr[0]

    async def post_configure_phase(self, phase):
        await super().post_configure_phase(phase)
        self.config_phase_finish_event.set()
        self.update_config_regs()

    def update_config_regs(self):
        # SPI mode   Clock polarity (CPOL)   Clock phase (CPHA)   Data is shifted out on                Data is sampled on
        #    0                   0                      0         falling SCLK, and when CS activates   rising SCLK
        #    1                   0                      1         rising SCLK                           falling SCLK
        #    2                   1                      0         rising SCLK, and when CS activates    falling SCLK
        #    3                   1                      1         falling SCLK                          rising SCLK
        config_reg = self.regs.read_reg_value(self.regs.reg_name_to_address["CFG"])
        self.cpol_val = config_reg & 0b1
        self.cpha_val = (config_reg & 0b10) >> 1
        uvm_info(self.tag, f"CPOL = {self.cpol_val} CPHA = {self.cpha_val}", UVM_LOW)

    async def sample_edge(self):
        if self.cpol_val == self.cpha_val:
            await RisingEdge(self.vif.SCK)
        else:
            await FallingEdge(self.vif.SCK)

    async def run_phase(self, phase):
        # monitoring should be dependents on the configuration of spi register CFG
        # this register should be set only in the configuration phase so the run phase shoud start after the configuration phase
        await self.config_phase_finish_event.wait()
        while True:
            await FallingEdge(self.vif.SSn)
            spi_thread = await cocotb.start(self.read_transaction())
            check_pr_thread = await cocotb.start(self.check_pr())
            await RisingEdge(self.vif.SSn)
            spi_thread.kill()
            check_pr_thread.kill()

    async def read_transaction(self):
        while True:
            mosi = 0
            miso = 0
            for clk_cycle in range(self.data_width):
                await self.sample_edge()
                if clk_cycle == 0:
                    self.start_new_tr_event.set()
                # mosi |= self.vif.MOSI.value.integer << clk_cycle
                mosi = self.vif.MOSI.value.integer | mosi << 1
                miso = self.vif.MISO.value.integer | miso << 1
                uvm_info(
                    self.tag,
                    f"read cycle {clk_cycle} mosi={mosi} miso={miso}",
                    UVM_MEDIUM,
                )
            uvm_info(self.tag, f"mosi={mosi} miso={miso}", UVM_MEDIUM)
            tr = self.update_tr(miso, mosi)
            self.monitor_port.write(tr)

    def update_tr(self, miso, mosi):
        tr = spi_item.type_id.create("tr", self)
        tr.MISO = miso
        tr.MOSI = mosi
        return tr

    async def check_pr(self):
        while True:
            await self.start_new_tr_event.wait()
            dut_pr = (
                self.regs.read_reg_value(self.regs.reg_name_to_address["PR"]) // 2 * 2
            )  # make even number
            self.start_new_tr_event.clear()
            counter = 0
            break_counter = 0
            old_val = self.vif.SCK.value
            while True:
                await ClockCycles(self.vif.CLK, 1)
                if self.vif.SCK.value == old_val:
                    counter += 1
                else:
                    old_val = self.vif.SCK.value
                    break_counter += 1
                if break_counter == 10:
                    break
            br_val = math.ceil(counter / break_counter) * 2
            if br_val != dut_pr:
                uvm_error(
                    self.tag,
                    f"data sent with wrong PR = {br_val} expected PR = {dut_pr}",
                )
            uvm_info(self.tag, f" counter = {counter} br_val = {br_val}", UVM_LOW)


uvm_component_utils(spi_monitor)
