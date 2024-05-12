from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
from uvm.base.uvm_object_globals import UVM_ALL_ON, UVM_NOPACK, UVM_HIGH, UVM_MEDIUM
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
import random
from spi_seq_lib.spi_MOSI_MISO_seq import spi_MOSI_MISO_seq


class spi_csb_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="spi_csb_seq", data_width=8):
        super().__init__(name)
        self.data_width = data_width
        regs_arr = []
        if not UVMConfigDb.get(self, "", "bus_regs", regs_arr):
            uvm_fatal(self.tag, "No json file wrapper regs")
        else:
            self.regs = regs_arr[0]

    async def body(self):
        await super().body()
        # Add the sequqnce here
        # you could use method send_req to send a write or read using the register name
        # example for writing register by value > 5
        for _ in range(30):
            if random.random() > 0.3:  # 70% probability of assert csb
                await self.send_req(
                    is_write=True, reg="CTRL", data_condition=lambda data: data == 0b1
                )
            await uvm_do(
                self,
                spi_MOSI_MISO_seq(
                    name="spi_MOSI_MISO_seq",
                    num_data=random.randint(1, 10),
                    disbale_control=True,
                ),
            )
            if random.random() > 0.3:  # 70% probability of deassert csb
                await self.send_req(
                    is_write=True, reg="CTRL", data_condition=lambda data: data == 0b0
                )  # csb disable


uvm_object_utils(spi_csb_seq)
