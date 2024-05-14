from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random


class spi_base_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="spi_base_seq"):
        super().__init__(name)

    async def wait_tx_fifo_empty(self):
        # wait until tx is empty
        self.clear_response_queue()
        while True:
            rsp = []
            await self.send_req(is_write=False, reg="STATUS")
            await self.get_response(rsp)
            rsp = rsp[0]
            if (
                rsp.addr == self.regs.reg_name_to_address["STATUS"]
                and rsp.data & 0b1 == 0b1
            ):
                break

        cycles_additional = 8 * 4
        for _ in range(cycles_additional):
            await self.send_nop()

    async def wait_rx_fifo_not_empty(self):
        # wait received fifo not empty
        self.clear_response_queue()
        while True:
            rsp = []
            self.clear_response_queue()
            await self.send_req(is_write=False, reg="STATUS")
            await self.get_response(rsp)
            rsp = rsp[0]
            if (
                rsp.addr == self.regs.reg_name_to_address["STATUS"]
                and rsp.data & 0b100 == 0b0
            ):
                break
            await self.send_req(
                is_write=True,
                reg="TXDATA",
                data_condition=lambda data: data == 0,
            )


uvm_object_utils(spi_base_seq)
