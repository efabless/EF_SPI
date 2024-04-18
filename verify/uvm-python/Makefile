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
TESTS := spi_first_test

# Variable for tag - set this as required
SIM_TAG ?= default_tag

# Define SIM_PATH variable
SIM_PATH := $(PWD)/sim/$(SIM_TAG)

# Check and clone EF_UVM repository at the beginning of the Makefile execution

clone_ef_uvm := $(shell if [ ! -d "EF_UVM" ]; then \
	echo "Cloning the EF_UVM repository..."; \
	git clone https://github.com/efabless/EF_UVM.git; \
fi;)


include EF_UVM/Makefile.test
