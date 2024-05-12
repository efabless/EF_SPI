from uvm.base.sv import sv_if


class spi_if(sv_if):
    def __init__(self, dut):
        bus_map = {
            "SCK": "SCK",
            "SSn": "SSn",
            "MOSI": "MOSI",
            "MISO": "MISO",
            "CLK": "CLK",
        }
        super().__init__(dut, "", bus_map)
