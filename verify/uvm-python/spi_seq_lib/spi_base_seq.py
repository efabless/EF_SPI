from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info, uvm_error, uvm_warning
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW, UVM_MEDIUM


class spi_base_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="spi_base_seq"):
        super().__init__(name)

    async def wait_tx_fifo_empty(self):
        # wait until tx is empty and not busy
        self.clear_response_queue()
        while True:
            rsp = []
            await self.send_req(is_write=False, reg="STATUS")
            await self.get_response(rsp)
            rsp = rsp[0]
            if (
                rsp.addr == self.regs.reg_name_to_address["STATUS"]
                and rsp.data & 0b1 == 0b1 and rsp.data & 0b1000000 == 0b0
            ):
                break
        # wait until not busy
        cycles_additional = 8 * 4
        for _ in range(cycles_additional):
            await self.send_nop()

    async def wait_rx_fifo_not_empty(self):
        # wait received fifo not empty
        self.clear_response_queue()
        await self.send_req(
            is_write=True,
            reg="TXDATA",
            data_condition=lambda data: data == 0,
        )
        while True:
            rsp = []
            self.clear_response_queue()
            await self.send_req(is_write=False, reg="STATUS")
            while self.response_queue.size() != 0:
                await self.get_response(rsp)
                uvm_info(self.get_full_name(), f"RSP: {rsp}", UVM_HIGH)
                if rsp[0].addr == self.regs.reg_name_to_address["STATUS"]:
                    break
            rsp = rsp[0]
            if (
                rsp.addr == self.regs.reg_name_to_address["STATUS"]
                and rsp.data & 0b100 == 0b0
            ):
                break
            


uvm_object_utils(spi_base_seq)
