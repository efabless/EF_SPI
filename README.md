# EF_SPI

SPI master controller with an APB interface
## The wrapped IP


 The IP comes with an APB Wrapper

### Wrapped IP System Integration

```verilog
EF_SPI_APB INST (
	`TB_APB_SLAVE_CONN,
	.dout(dout)
	.din(din)
	.csb(csb)
	.sclk(sclk)
);
```
> **_NOTE:_** `TB_APB_SLAVE_CONN is a convenient macro provided by [BusWrap](https://github.com/efabless/BusWrap/tree/main).

## Implementation example  

The following table is the result for implementing the EF_SPI IP with different wrappers using Sky130 PDK and [OpenLane2](https://github.com/efabless/openlane2) flow.
|Module | Number of cells | Max. freq |
|---|---|---|
|EF_SPI|N/A| N/A |
|EF_SPI_APB|N/A|N/A|
## The Programming Interface


### Registers

|Name|Offset|Reset Value|Access Mode|Description|
|---|---|---|---|---|
|DATA|0000|0x00000000|w|Data transmitted and received|
|CFG|0008|0x00000000|w||
|STATUS|0010|0x00000000|r||
|CTRL|0018|0x00000000|w||
|PR|0020|0x00000000|w|SCK PRESCALER|
|IM|0f00|0x00000000|w|Interrupt Mask Register; write 1/0 to enable/disable interrupts; check the interrupt flags table for more details|
|RIS|0f08|0x00000000|w|Raw Interrupt Status; reflects the current interrupts status;check the interrupt flags table for more details|
|MIS|0f04|0x00000000|w|Masked Interrupt Status; On a read, this register gives the current masked status value of the corresponding interrupt. A write has no effect; check the interrupt flags table for more details|
|IC|0f0c|0x00000000|w|Interrupt Clear Register; On a write of 1, the corresponding interrupt (both raw interrupt and masked interrupt, if enabled) is cleared; check the interrupt flags table for more details|

### DATA Register [Offset: 0x0, mode: w]

Data transmitted and received
<img src="https://svg.wavedrom.com/{reg:[{name:'DATA', bits:8},{bits: 24}], config: {lanes: 2, hflip: true}} "/>


### CFG Register [Offset: 0x8, mode: w]


<img src="https://svg.wavedrom.com/{reg:[{name:'cpol', bits:1},{name:'cpha', bits:1},{bits: 30}], config: {lanes: 2, hflip: true}} "/>

|bit|field name|width|description|
|---|---|---|---|
|0|cpol|1||
|1|cpha|1||


### STATUS Register [Offset: 0x10, mode: r]


<img src="https://svg.wavedrom.com/{reg:[{name:'STATUS', bits:1},{bits: 31}], config: {lanes: 2, hflip: true}} "/>


### CTRL Register [Offset: 0x18, mode: w]


<img src="https://svg.wavedrom.com/{reg:[{name:'start', bits:1},{name:'SSn', bits:1},{bits: 30}], config: {lanes: 2, hflip: true}} "/>

|bit|field name|width|description|
|---|---|---|---|
|0|start|1||
|1|SSn|1||


### PR Register [Offset: 0x20, mode: w]

SCK PRESCALER
<img src="https://svg.wavedrom.com/{reg:[{name:'PR', bits:16},{bits: 16}], config: {lanes: 2, hflip: true}} "/>


### Interrupt Flags

The wrapped IP provides four registers to deal with interrupts: IM, RIS, MIS and IC. These registers exist for all wrapper types generated by the [BusWrap](https://github.com/efabless/BusWrap/tree/main) `bus_wrap.py` utility. 

Each register has a group of bits for the interrupt sources/flags.
- `IM`: is used to enable/disable interrupt sources.

- `RIS`: has the current interrupt status (interrupt flags) whether they are enabled or disabled.

- `MIS`: is the result of masking (ANDing) RIS by IM.

- `IC`: is used to clear an interrupt flag.


The following are the bit definitions for the interrupt registers:

|Bit|Flag|Width|Description|
|---|---|---|---|
|0|DONE|-1|transimation is done|

### The Interface 


#### Module Parameters 

|Parameter|Description|Default Value|
|---|---|---|
|DATA_WIDTH|The number of bits of data per transaction|16|
|NUM_PORTS|Number of data ports|1|
|CLK_DIVIDER_WIDTH|=Number of bits for the clock divider (used to generate spi clock from main clock)|8|
|SAMPLE_PHASE||0|

#### Ports 

|Port|Direction|Width|Description|
|---|---|---|---|
|dout|input|NUM_PORTS|None|
|din|output|NUM_PORTS|None|
|csb|output|1|None|
|sclk|output|1|None|
|clk|input|1|None|
|resetb|input|1|None|
|CPOL|input|1|None|
|CPHA|input|1|None|
|clk_divider|input|CLK_DIVIDER_WIDTH|None|
|go|input|1|None|
|datai|input|NUM_PORTS*DATA_WIDTH|None|
|datao|output|NUM_PORTS*DATA_WIDTH|None|
|busy|output|1|None|
|done|output|1|None|
|dout|input|NUM_PORTS|None|
|din|output|NUM_PORTS|None|
|csb|output|1|None|
|sclk|output|1|None|
## F/W Usage Guidelines:
## Installation:
You can either clone repo or use [IPM](https://github.com/efabless/IPM) which is an open-source IPs Package Manager
* To clone repo:
```git clone https://https: //github.com/efabless/EF_SPI```
* To download via IPM , follow installation guides [here](https://github.com/efabless/IPM/blob/main/README.md) then run 
```ipm install EF_SPI```
### Run cocotb UVM Testbench:
In IP directory run:
 ```shell
 cd verify/uvm-python/
 ```
 ##### To run testbench for design with APB 
 To run all tests:
 ```shell
 make run_all_tests BUS_TYPE=APB
 ```
 To run a certain test:
 ```shell
 make run_<test_name> BUS_TYPE=APB
 ```
 To run all tests with a tag: 
 ```shell
 make run_all_tests TAG=<new_tag> BUS_TYPE=APB
 ```
 ##### To run testbench for design with APB
 To run all tests:
 ```shell
 make run_all_tests BUS_TYPE=AHB
 ```
 To run a certain test:
 ```shell
 make run_<test_name> BUS_TYPE=AHB
 ```
 To run all tests with a tag: 
 ```shell
 make run_all_tests TAG=<new_tag> BUS_TYPE=AHB
```
