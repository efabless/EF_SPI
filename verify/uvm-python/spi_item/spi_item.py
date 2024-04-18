from uvm.seq.uvm_sequence_item import UVMSequenceItem
from uvm.macros import (
    uvm_object_utils_begin,
    uvm_object_utils_end,
    uvm_field_int,
    uvm_object_utils,
    uvm_error,
    uvm_info,
)
from uvm.base.uvm_object_globals import UVM_ALL_ON, UVM_NOPACK, UVM_HIGH, UVM_MEDIUM
from uvm.base.sv import sv
from EF_UVM.ip_env.ip_item import ip_item


class spi_item(ip_item):
    def __init__(self, name="spi_item"):
        super().__init__(name)
        self.data_width = 8
        self.MOSI = 0
        self.rand("MOSI", range(0, (1 << self.data_width) - 1))
        self.MISO = 0

    def convert2string(self):
        return f"data master to slave = {bin(self.MOSI).zfill(self.data_width)} slave to master = {bin(self.MISO).zfill(self.data_width)}"

    def do_compare(self, tr):
        if self.MISO == tr.MISO:
            return True
        return False


uvm_object_utils(spi_item)
