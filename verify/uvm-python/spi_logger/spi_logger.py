from EF_UVM.ip_env.ip_logger.ip_logger import ip_logger
import cocotb
from uvm.macros import uvm_component_utils, uvm_fatal


class spi_logger(ip_logger):
    def __init__(self, name="spi_logger", parent=None):
        super().__init__(name, parent)
        self.header = ["Time (ns)", "MOSI", "MISO", "PR"]
        self.col_widths = [10] * len(self.header)

    def logger_formatter(self, transaction):
        sim_time = f"{cocotb.utils.get_sim_time(units='ns')} ns"
        miso = f"{hex(transaction.MISO)}({bin(transaction.MISO).zfill(8)})"
        mosi = f"{hex(transaction.MOSI)}({bin(transaction.MOSI).zfill(8)})"
        pr = f"{hex(transaction.pre_scale)}"
        # this called when new transaction is called from ip monitor
        # TODO: should return the list of strings by the information in the header with the same order
        return [sim_time, mosi, miso, pr]


uvm_component_utils(spi_logger)
