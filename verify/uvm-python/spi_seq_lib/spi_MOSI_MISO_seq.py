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
from spi_seq_lib.spi_base_seq import spi_base_seq


class spi_MOSI_MISO_seq(spi_base_seq):
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
        if not self.disable_control:
            await self.send_req(
                is_write=True, reg="CTRL", data_condition=lambda data: data == 0b0
            )
        for _ in range(self.num_data):
            # 2 tx then 1 read from rx
            if not self.disable_control:
                await self.send_req(
                    is_write=True, reg="CTRL", data_condition=lambda data: data == 0b111
                )
            await self.send_req(
                is_write=True,
                reg="TXDATA",
                data_condition=lambda data: data < (1 << self.data_width) - 1,
            )
            await self.send_req(
                is_write=True,
                reg="TXDATA",
                data_condition=lambda data: data < (1 << self.data_width) - 1,
            )

            # wait until tx is empty
            await self.wait_tx_fifo_empty()

            await self.send_req(is_write=False, reg="RXDATA")
        if not self.disable_control:
            await self.send_req(
                is_write=True, reg="CTRL", data_condition=lambda data: data == 0b00
            )  # csb disable


uvm_object_utils(spi_MOSI_MISO_seq)
