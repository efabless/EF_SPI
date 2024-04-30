PLUSARGS += "+UVM_VERBOSITY=UVM_MEDUIM"
TOPLEVEL := top
MODULE   ?= top_module
AHB_FILES ?= 
APB_FILES ?= $(PWD)/../../hdl/rtl/bus_wrappers/APB_SPI.v
WB_FILES ?=
HDL_FILES ?= $(PWD)/../../hdl/rtl/spi_master.v
VERILOG_SOURCES ?=  $(PWD)/top.v $(AHB_FILES) $(APB_FILES) $(WB_FILES) $(HDL_FILES)
RTL_MACROS += "" # Add macros needed
BUS_TYPE = APB # only APB is supported
RTL_MACROS += -DBUS_TYPE_APB

# RTL_MACROS ?= "-DSKIP_WAVE_DUMP"
YAML_FILE = $(PWD)/../../EF_SPI.yaml # TODO: update yaml file path
MAKEFLAGS += --no-print-directory 

# List of tests
TESTS := MOSI_stress_test MISO_stress_test MISO_MOSI_test spi_csb_test spi_pr_test

# Variable for tag - set this as required
SIM_TAG ?= default_tag

# Define SIM_PATH variable
SIM_PATH := $(PWD)/sim/$(SIM_TAG)

# Check and clone EF_UVM repository at the beginning of the Makefile execution
## netlist Gen 
DESIGN_NAME = EF_SPI_APB
export CLK_MAKEFILE = PCLK
export RST_MAKEFILE = PRESETn
GL_MACROS += -DGL -DFUNCTIONAL  $(RTL_MACROS) -DUNIT_DELAY=\#1 
PRE_SYS_FILES = $(AHB_FILES) $(APB_FILES) $(WB_FILES) $(HDL_FILES)
PDK_DIR = $(HOME)/.volare/volare/sky130/versions/bdc9412b3e468c102d01b7cf6337be06ec6e9c9a/sky130A/
PDK_FILES = $(PDK_DIR)/libs.ref/sky130_fd_sc_hd/verilog/primitives.v $(PDK_DIR)/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v # get this from openlane logs in the future 
POST_SYS_FILES = $(PWD)/top.v $(VIP_FILES) $(PWD)/../../hdl/gl/synthesis/nl/$(DESIGN_NAME).nl.v

clone_ef_uvm := $(shell if [ ! -d "EF_UVM" ]; then \
	echo "Cloning the EF_UVM repository..."; \
	git clone https://github.com/efabless/EF_UVM.git; \
fi;)


include EF_UVM/Makefile.test
