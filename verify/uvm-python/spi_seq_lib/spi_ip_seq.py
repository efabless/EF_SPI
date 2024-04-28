from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
from uvm.base import sv, UVM_HIGH, UVM_LOW
from uvm.macros.uvm_message_defines import uvm_info, uvm_fatal
from spi_item.spi_item import spi_item
from uvm.seq import UVMSequence


class spi_ip_seq(UVMSequence):
    # use this sequence write or read from register by the ip interface
    # this sequence should be connected to the ip sequencer in the testbench
    # you should add as many sequences as you need not only this one
    def __init__(self, name="spi_ip_seq"):
        UVMSequence.__init__(self, name)
        self.set_automatic_phase_objection(1)
        self.req = spi_item()
        self.rsp = spi_item()
        self.tag = name

    async def body(self):
        # Add sequence to be used by the ip sequencer
        uvm_info(self.tag, "Add sequence to be used by the ip sequencer", UVM_LOW)
        while True:
            await uvm_do(self, self.req)
        pass


uvm_object_utils(spi_ip_seq)
