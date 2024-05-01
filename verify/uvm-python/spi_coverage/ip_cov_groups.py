from uvm.macros.uvm_message_defines import uvm_info
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW
from cocotb_coverage.coverage import CoverPoint, CoverCross
from uvm.macros import uvm_component_utils


class ip_cov_groups:
    def __init__(self, hierarchy, regs) -> None:
        self.hierarchy = hierarchy
        self.regs = regs
        self.ip_cov(None, do_sampling=False)
        self.item_width = 8

    def ip_cov(self, tr, do_sampling=True):
        @CoverPoint(
            f"{self.hierarchy}.MISO",
            xf=lambda tr: tr.MISO,
            bins=[(0, 0xF), (0x10, 0xF0), (0xF1, 0xFF)],
            at_least=3,
            rel=lambda val, b: b[0] <= val <= b[1],
        )
        @CoverPoint(
            f"{self.hierarchy}.MOSI",
            xf=lambda tr: tr.MOSI,
            bins=[(0, 0xF), (0x10, 0xF0), (0xF1, 0xFF)],
            at_least=3,
            rel=lambda val, b: b[0] <= val <= b[1],
        )
        @CoverPoint(
            f"{self.hierarchy}.clock_polarity",
            xf=lambda tr: self.regs.read_reg_value("CFG") & 0b1,
            bins=[False, True],
            bins_labels=["normal", "inverted"],
            at_least=3,
        )
        @CoverPoint(
            f"{self.hierarchy}.clock_phase",
            xf=lambda tr: (self.regs.read_reg_value("CFG") & 0b10) >> 1,
            bins=[False, True],
            bins_labels=["normal", "shifted90"],
            at_least=3,
        )
        @CoverPoint(
            f"{self.hierarchy}.PRESCALER",
            xf=lambda tr: self.regs.read_reg_value("PR"),
            bins=[(0, 0x5), (0x5, 0xFFFF)],
            at_least=3,
            rel=lambda val, b: b[0] <= val <= b[1],
        )
        @CoverCross(
            f"{self.hierarchy}.clock_polarity_phase",
            items=[f"{self.hierarchy}.clock_polarity", f"{self.hierarchy}.clock_phase"],
        )
        def sample(tr):
            uvm_info("coverage_ip", f"tr = {tr}", UVM_LOW)

        if do_sampling:
            sample(tr)
