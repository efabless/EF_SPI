import cocotb
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
from uvm.base.uvm_config_db import UVMConfigDb
from uvm.base.uvm_object_globals import UVM_LOW
from uvm.base.uvm_globals import run_test
from spi_interface.spi_if import spi_if
from EF_UVM.bus_env.bus_interface.bus_if import (
    bus_apb_if,
    bus_irq_if,
    bus_ahb_if,
    bus_wb_if,
)
from cocotb_coverage.coverage import coverage_db
from cocotb.triggers import Event, First
from EF_UVM.bus_env.bus_regs import bus_regs
from uvm.base import UVMRoot
from EF_UVM.base_test import base_test

# seqences import
from spi_seq_lib.spi_bus_seq import spi_bus_seq
from spi_seq_lib.spi_ip_seq import spi_ip_seq
from spi_seq_lib.spi_send_MOSI_seq import spi_send_MOSI_seq
from spi_seq_lib.spi_send_MISO_seq import spi_send_MISO_seq
from spi_seq_lib.spi_MOSI_MISO_seq import spi_MOSI_MISO_seq
from spi_seq_lib.spi_csb_seq import spi_csb_seq
from spi_seq_lib.spi_pr_seq import spi_pr_seq
from spi_seq_lib.configure_spi_seq import configure_spi_seq

# override classes
from EF_UVM.ip_env.ip_agent.ip_driver import ip_driver
from spi_agent.spi_driver import spi_driver
from EF_UVM.ip_env.ip_agent.ip_monitor import ip_monitor
from spi_agent.spi_monitor import spi_monitor
from EF_UVM.ref_model.ref_model import ref_model
from spi_ref_model.spi_ref_model import spi_ref_model
from EF_UVM.ip_env.ip_coverage.ip_coverage import ip_coverage
from spi_coverage.spi_coverage import spi_coverage
from EF_UVM.ip_env.ip_logger.ip_logger import ip_logger
from spi_logger.spi_logger import spi_logger


@cocotb.test()
async def module_top(dut):
    # profiler = cProfile.Profile()
    # profiler.enable()
    BUS_TYPE = cocotb.plusargs["BUS_TYPE"]
    pif = spi_if(dut)
    if BUS_TYPE == "APB":
        w_if = bus_apb_if(dut)
    elif BUS_TYPE == "AHB":
        w_if = bus_ahb_if(dut)
    elif BUS_TYPE == "WISHBONE":
        w_if = bus_wb_if(dut)
    else:
        uvm_fatal("module_top", f"unknown bus type {BUS_TYPE}")
    w_irq_if = bus_irq_if(dut)
    UVMConfigDb.set(None, "*", "ip_if", pif)
    UVMConfigDb.set(None, "*", "bus_if", w_if)
    UVMConfigDb.set(None, "*", "bus_irq_if", w_irq_if)
    yaml_file = []
    UVMRoot().clp.get_arg_values("+YAML_FILE=", yaml_file)
    yaml_file = yaml_file[0]
    regs = bus_regs(yaml_file)
    UVMConfigDb.set(None, "*", "bus_regs", regs)
    UVMConfigDb.set(None, "*", "irq_exist", regs.get_irq_exist())
    UVMConfigDb.set(None, "*", "collect_coverage", True)
    UVMConfigDb.set(None, "*", "disable_logger", False)
    test_path = []
    UVMRoot().clp.get_arg_values("+TEST_PATH=", test_path)
    test_path = test_path[0]
    await run_test()
    coverage_db.export_to_yaml(filename=f"{test_path}/coverage.yalm")
    # profiler.disable()
    # profiler.dump_stats("profile_result.prof")


class spi_base_test(base_test):
    def __init__(self, name="spi_first_test", parent=None):
        BUS_TYPE = cocotb.plusargs["BUS_TYPE"]
        super().__init__(name, bus_type=BUS_TYPE, parent=parent)
        self.tag = name

    def build_phase(self, phase):
        super().build_phase(phase)
        # override
        self.set_type_override_by_type(ip_driver.get_type(), spi_driver.get_type())
        self.set_type_override_by_type(ip_monitor.get_type(), spi_monitor.get_type())
        self.set_type_override_by_type(ref_model.get_type(), spi_ref_model.get_type())
        self.set_type_override_by_type(ip_coverage.get_type(), spi_coverage.get_type())
        self.set_type_override_by_type(ip_logger.get_type(), spi_logger.get_type())

    async def configure_phase(self, phase):
        phase.raise_objection(
            self, f"{self.__class__.__name__} configure phase OBJECTED "
        )
        bus_seq = configure_spi_seq("configure_spi_seq")
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(
            self, f"{self.__class__.__name__} configure phase drop objection"
        )
        await super().configure_phase(phase)


uvm_component_utils(spi_base_test)


class MOSI_stress_test(spi_base_test):
    def __init__(self, name="MOSI_stress_test", parent=None):
        super().__init__(name, parent=parent)
        self.tag = name

    async def main_phase(self, phase):
        uvm_info(self.tag, f"Starting test {self.__class__.__name__}", UVM_LOW)
        phase.raise_objection(self, f"{self.__class__.__name__} OBJECTED")
        # TODO: conntect sequence with sequencer here
        # for example if you need to run the 2 sequence sequentially
        bus_seq = spi_send_MOSI_seq("spi_send_MOSI_seq", num_data=200)
        ip_seq = spi_ip_seq("spi_ip_seq")
        await cocotb.start(ip_seq.start(self.ip_sqr))
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(self, f"{self.__class__.__name__} drop objection")


uvm_component_utils(MOSI_stress_test)


class MISO_stress_test(spi_base_test):
    def __init__(self, name="MISO_stress_test", parent=None):
        super().__init__(name, parent=parent)
        self.tag = name

    async def main_phase(self, phase):
        uvm_info(self.tag, f"Starting test {self.__class__.__name__}", UVM_LOW)
        phase.raise_objection(self, f"{self.__class__.__name__} OBJECTED")
        # TODO: conntect sequence with sequencer here
        # for example if you need to run the 2 sequence sequentially
        bus_seq = spi_send_MISO_seq("spi_send_MISO_seq", num_data=500)
        ip_seq = spi_ip_seq("spi_ip_seq")
        await cocotb.start(ip_seq.start(self.ip_sqr))
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(self, f"{self.__class__.__name__} drop objection")


uvm_component_utils(MISO_stress_test)


class MISO_MOSI_test(spi_base_test):
    def __init__(self, name="MISO_MOSI_test", parent=None):
        super().__init__(name, parent=parent)
        self.tag = name

    async def main_phase(self, phase):
        uvm_info(self.tag, f"Starting test {self.__class__.__name__}", UVM_LOW)
        phase.raise_objection(self, f"{self.__class__.__name__} OBJECTED")
        # TODO: conntect sequence with sequencer here
        # for example if you need to run the 2 sequence sequentially
        bus_seq = spi_MOSI_MISO_seq("spi_MOSI_MISO_seq", num_data=500)
        ip_seq = spi_ip_seq("spi_ip_seq")
        await cocotb.start(ip_seq.start(self.ip_sqr))
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(self, f"{self.__class__.__name__} drop objection")


uvm_component_utils(MISO_MOSI_test)


class spi_csb_test(spi_base_test):
    def __init__(self, name="spi_csb_test", parent=None):
        super().__init__(name, parent=parent)
        self.tag = name

    async def main_phase(self, phase):
        uvm_info(self.tag, f"Starting test {self.__class__.__name__}", UVM_LOW)
        phase.raise_objection(self, f"{self.__class__.__name__} OBJECTED")
        # TODO: conntect sequence with sequencer here
        # for example if you need to run the 2 sequence sequentially
        bus_seq = spi_csb_seq("spi_csb_seq")
        ip_seq = spi_ip_seq("spi_ip_seq")
        await cocotb.start(ip_seq.start(self.ip_sqr))
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(self, f"{self.__class__.__name__} drop objection")


uvm_component_utils(spi_csb_test)


class spi_pr_test(spi_base_test):
    def __init__(self, name="spi_pr_test", parent=None):
        super().__init__(name, parent=parent)
        self.tag = name

    async def main_phase(self, phase):
        uvm_info(self.tag, f"Starting test {self.__class__.__name__}", UVM_LOW)
        phase.raise_objection(self, f"{self.__class__.__name__} OBJECTED")
        # TODO: conntect sequence with sequencer here
        # for example if you need to run the 2 sequence sequentially
        bus_seq = spi_pr_seq("spi_pr_seq")
        ip_seq = spi_ip_seq("spi_ip_seq")
        await cocotb.start(ip_seq.start(self.ip_sqr))
        await bus_seq.start(self.bus_sqr)
        phase.drop_objection(self, f"{self.__class__.__name__} drop objection")


uvm_component_utils(spi_pr_test)
