from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random


class configure_spi_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="configure_spi_seq"):
        super().__init__(name)

    async def body(self):
        await super().body()
        # Add the sequqnce here
        # you could use method send_req to send a write or read using the register name
        # example for writing register by value > 5
        await self.send_req(
            is_write=True,
            reg="CFG",
            data_condition=lambda data: data in [0b00],
            # data_condition=lambda data: data in [0b00, 0b01, 0b10, 0b11],
        )
        rsp = []
        await self.get_response(rsp)  # wait until writing is done


uvm_object_utils(configure_spi_seq)
