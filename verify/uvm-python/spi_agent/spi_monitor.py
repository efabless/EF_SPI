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

    def build_phase(self, phase):
        super().build_phase(phase)
        # get data width
        arr = []
        if not UVMConfigDb.get(self, "", "DATA_WIDTH", arr):
            self.data_width = 8
        else:
            self.data_width = arr[0]

    async def run_phase(self, phase):
        while True:
            await FallingEdge(self.vif.SSn)
            spi_thread = await cocotb.start(self.read_transaction())
            await RisingEdge(self.vif.SSn)
            spi_thread.kill()

    async def read_transaction(self):
        mosi = 0
        miso = 0
        for clk_cycle in range(self.data_width):
            await RisingEdge(self.vif.CLK)
            mosi |= self.vif.MOSI.value.integer << clk_cycle
            miso |= self.vif.MISO.value.integer << clk_cycle
            uvm_info(
                self.tag, f"read cycle {clk_cycle} mosi={mosi} miso={miso}", UVM_MEDIUM
            )
        uvm_info(self.tag, f"mosi={mosi} miso={miso}", UVM_MEDIUM)
        tr = self.update_tr(miso, mosi)
        self.monitor_port.write(tr)

    def update_tr(self, miso, mosi):
        tr = spi_item.type_id.create("tr", self)
        tr.miso = miso
        tr.mosi = mosi
        return tr


uvm_component_utils(spi_monitor)
