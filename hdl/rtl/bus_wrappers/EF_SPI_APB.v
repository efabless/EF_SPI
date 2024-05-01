/*
	Copyright 2023 Mohamed Shalan

	Author: Mohamed Shalan (mshalan@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale			1ns/1ps
`default_nettype	none

`define				APB_AW		16

`include			"apb_wrapper.vh"

module EF_SPI_APB #( 
	parameter	
		CDW = 8
) (
	`APB_SLAVE_PORTS,
	input	[1-1:0]	dout,
	output	[1-1:0]	din,
	output	[1-1:0]	csb,
	output	[1-1:0]	sclk
);

	localparam	DATA_REG_OFFSET = `APB_AW'd0;
	localparam	CFG_REG_OFFSET = `APB_AW'd8;
	localparam	STATUS_REG_OFFSET = `APB_AW'd16;
	localparam	CTRL_REG_OFFSET = `APB_AW'd24;
	localparam	PR_REG_OFFSET = `APB_AW'd32;
	localparam	IM_REG_OFFSET = `APB_AW'd3840;
	localparam	MIS_REG_OFFSET = `APB_AW'd3844;
	localparam	RIS_REG_OFFSET = `APB_AW'd3848;
	localparam	IC_REG_OFFSET = `APB_AW'd3852;

	wire		clk = PCLK;
	wire		rst_n = PRESETn;


	`APB_CTRL_SIGNALS

	wire [1-1:0]	CPOL;
	wire [1-1:0]	CPHA;
	wire [CDW-1:0]	clk_divider;
	wire [1-1:0]	go;
	wire [8-1:0]	datai;
	wire [8-1:0]	datao;
	wire [1-1:0]	busy;
	wire [1-1:0]	done;
	wire [1-1:0]	ss;


	// Register Definitions
	reg	[8-1:0]	DATA_REG;
	wire	[8-1:0]	DATA_WIRE;
	assign	DATA_WIRE = datao;
	assign	datai = DATA_REG;
	`APB_REG(DATA_REG, 0, 8)

	reg [1:0]	CFG_REG;
	assign	CPOL	=	CFG_REG[0 : 0];
	assign	CPHA	=	CFG_REG[1 : 1];
	`APB_REG(CFG_REG, 0, 2)

	wire [2-1:0]	STATUS_WIRE;
	assign	STATUS_WIRE[0 : 0] = done;
	assign	STATUS_WIRE[1 : 1] = busy;

	reg [1:0]	CTRL_REG;
	assign	go	=	CTRL_REG[0 : 0];
	assign	ss	=	CTRL_REG[1 : 1];
	`APB_REG_AC(CTRL_REG, 0, 2, 2'h2)

	reg [15:0]	PR_REG;
	assign	clk_divider = PR_REG;
	`APB_REG(PR_REG, 'h2, 16)

	reg [0:0] IM_REG;
	reg [0:0] IC_REG;
	reg [0:0] RIS_REG;

	`APB_MIS_REG(1)
	`APB_REG(IM_REG, 0, 1)
	`APB_IC_REG(1)

	wire [0:0] Done = done;


	integer _i_;
	`APB_BLOCK(RIS_REG, 0) else begin
		for(_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(Done[_i_ - 0] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
	end

	assign IRQ = |MIS_REG;

	EF_SPI #(
		.CDW(CDW)
	) instance_to_wrap (
		.clk(clk),
		.rst_n(rst_n),
		.CPOL(CPOL),
		.CPHA(CPHA),
		.clk_divider(clk_divider),
		.go(go),
		.datai(datai),
		.datao(datao),
		.busy(busy),
		.done(done),
		.ss(ss),
		.dout(dout),
		.din(din),
		.csb(csb),
		.sclk(sclk)
	);

	assign	PRDATA = 
			(PADDR[`APB_AW-1:0] == DATA_REG_OFFSET)	? DATA_WIRE :
			(PADDR[`APB_AW-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(PADDR[`APB_AW-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[`APB_AW-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[`APB_AW-1:0] == PR_REG_OFFSET)	? PR_REG :
			(PADDR[`APB_AW-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[`APB_AW-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[`APB_AW-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[`APB_AW-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	assign	PREADY = 1'b1;

endmodule
