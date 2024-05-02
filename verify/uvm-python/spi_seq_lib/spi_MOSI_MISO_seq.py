from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
from uvm.base.uvm_object_globals import (
    UVM_ALL_ON,
    UVM_NOPACK,
    UVM_HIGH,
    UVM_MEDIUM,
    UVM_LOW,
)
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
import random


class spi_MOSI_MISO_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(
        self, name="spi_MOSI_MISO_seq", num_data=10, data_width=8, disbale_control=False
    ):
        super().__init__(name)
        self.num_data = num_data
        self.data_width = data_width
        regs_arr = []
        if not UVMConfigDb.get(self, "", "bus_regs", regs_arr):
            uvm_fatal(self.tag, "No json file wrapper regs")
        else:
            self.regs = regs_arr[0]
        self.disable_control = disbale_control

    async def body(self):
        await super().body()
        # Add the sequqnce here
        # you could use method send_req to send a write or read using the register name
        # example for writing register by value > 5
        if not self.disable_control:
            await self.send_req(
                is_write=True, reg="CTRL", data_condition=lambda data: data == 0b10
            )
        for _ in range(self.num_data):
            if random.random() > 0.3:  # 70% probability of writing different value
                await self.send_req(
                    is_write=True,
                    reg="DATA",
                    data_condition=lambda data: data < (1 << self.data_width) - 1,
                )
            await self.send_req(
                is_write=True, reg="CTRL", data_condition=lambda data: data == 0b11
            )  # go
            await self.send_nop()
            await self.send_nop()
            # wait until the response status is busy 
            while True:
                await self.send_req(is_write=False, reg="STATUS")
                rsp = []
                await self.get_response(rsp)
                rsp = rsp[0]
                uvm_info(self.get_full_name(), f"RSP: {rsp}", UVM_MEDIUM)
                if rsp.addr == self.regs.reg_name_to_address["STATUS"] and rsp.data & 0b10 == 0b10:  # busy
                    break
            # wait until not busy
            while True:
                await self.send_nop()
                await self.send_req(is_write=False, reg="STATUS")
                rsp = []
                await self.get_response(rsp)
                rsp = rsp[0]
                uvm_info(self.get_full_name(), f"RSP: {rsp} id {rsp.id}", UVM_MEDIUM)
                if rsp.addr == self.regs.reg_name_to_address["STATUS"] and rsp.data & 0b10 == 0b0:
                    break
            if random.random() > 0.3:  # 70% probability of reading
                await self.send_req(is_write=False, reg="DATA")
        if not self.disable_control:
            await self.send_req(
                is_write=True, reg="CTRL", data_condition=lambda data: data == 0b00
            )  # csb disable


uvm_object_utils(spi_MOSI_MISO_seq)
