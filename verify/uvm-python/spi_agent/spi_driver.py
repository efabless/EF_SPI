from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info, uvm_warning
from uvm.base.uvm_config_db import UVMConfigDb
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW, UVM_MEDIUM
from cocotb.triggers import Timer, ClockCycles, FallingEdge, Event, RisingEdge, First
import cocotb
import random
from EF_UVM.ip_env.ip_agent.ip_driver import ip_driver


class spi_driver(ip_driver):
    def __init__(self, name="spi_driver", parent=None):
        super().__init__(name, parent)
        self.tag = name
        self.cpol_val = 0
        self.cpha_val = 0

    async def post_configure_phase(self, phase):
        await super().post_configure_phase(phase)
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

    async def driving_edge(self):
        if self.cpol_val != self.cpha_val:
            await RisingEdge(self.vif.SCK)
        else:
            await FallingEdge(self.vif.SCK)

    async def run_phase(self, phase):
        uvm_info(self.tag, "run_phase started", UVM_LOW)
        while True:
            tr = []
            await self.seq_item_port.get_next_item(tr)
            uvm_info(self.tag, f"Got transaction {tr[0]}", UVM_LOW)
            tr = tr[0]
            for i in range(7, -1, -1):  # drive the most significant bit first
                if self.cpha_val == 1:
                    await self.driving_edge()
                self.vif.MISO.value = (tr.MISO >> i) & 0b1
                if self.cpha_val == 0:
                    await self.driving_edge()
            # use self.vif.<signal name> for driving interface signals
            self.seq_item_port.item_done()


uvm_component_utils(spi_driver)
