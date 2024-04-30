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



/*
	Copyright 2020 AUCOHL

    Author: Mohamed Shalan (mshalan@aucegypt.edu)
	
	Licensed under the Apache License, Version 2.0 (the "License"); 
	you may not use this file except in compliance with the License. 
	You may obtain a copy of the License at:

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software 
	distributed under the License is distributed on an "AS IS" BASIS, 
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
	See the License for the specific language governing permissions and 
	limitations under the License.
*/
































                                        


module EF_SPI_WB #( 
	parameter	
		CLK_DIVIDER_WIDTH = 8
) (
	input   wire            ext_clk,
                                        input   wire            clk_i,
                                        input   wire            rst_i,
                                        input   wire [31:0]     adr_i,
                                        input   wire [31:0]     dat_i,
                                        output  wire [31:0]     dat_o,
                                        input   wire [3:0]      sel_i,
                                        input   wire            cyc_i,
                                        input   wire            stb_i,
                                        output  reg             ack_o,
                                        input   wire            we_i,
                                        output  wire            IRQ,
	input	[1-1:0]	dout,
	output	[1-1:0]	din,
	output	[1-1:0]	csb,
	output	[1-1:0]	sclk
);

	localparam	DATA_REG_OFFSET = 16'd0;
	localparam	CFG_REG_OFFSET = 16'd8;
	localparam	STATUS_REG_OFFSET = 16'd16;
	localparam	CTRL_REG_OFFSET = 16'd24;
	localparam	PR_REG_OFFSET = 16'd32;
	localparam	IM_REG_OFFSET = 16'd3840;
	localparam	MIS_REG_OFFSET = 16'd3844;
	localparam	RIS_REG_OFFSET = 16'd3848;
	localparam	IC_REG_OFFSET = 16'd3852;

	wire		clk = clk_i;
	wire		resetb = (~rst_i);


	wire            wb_valid    = cyc_i & stb_i;
                                        wire            wb_we       = we_i & wb_valid;
                                        wire            wb_re       = ~we_i & wb_valid;
                                        wire[3:0]       wb_byte_sel = sel_i & {4{wb_we}};

	wire [1-1:0]	CPOL;
	wire [1-1:0]	CPHA;
	wire [CLK_DIVIDER_WIDTH-1:0]	clk_divider;
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
	always @(posedge clk_i or posedge rst_i) if(rst_i) DATA_REG <= 0; else if(wb_we & (adr_i[16-1:0]==DATA_REG_OFFSET)) DATA_REG <= dat_i[8-1:0];

	reg [1:0]	CFG_REG;
	assign	CPOL	=	CFG_REG[0 : 0];
	assign	CPHA	=	CFG_REG[1 : 1];
	always @(posedge clk_i or posedge rst_i) if(rst_i) CFG_REG <= 0; else if(wb_we & (adr_i[16-1:0]==CFG_REG_OFFSET)) CFG_REG <= dat_i[2-1:0];

	wire [2-1:0]	STATUS_WIRE;
	assign	STATUS_WIRE[0 : 0] = done;
	assign	STATUS_WIRE[1 : 1] = busy;

	reg [1:0]	CTRL_REG;
	assign	go	=	CTRL_REG[0 : 0];
	assign	ss	=	CTRL_REG[1 : 1];
	always @(posedge clk_i or posedge rst_i) if(rst_i) CTRL_REG <= 0; else if(wb_we & (adr_i[16-1:0]==CTRL_REG_OFFSET)) CTRL_REG <= dat_i[2-1:0]; else CTRL_REG <= 2'h2 & CTRL_REG;

	reg [15:0]	PR_REG;
	assign	clk_divider = PR_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) PR_REG <= 'h2; else if(wb_we & (adr_i[16-1:0]==PR_REG_OFFSET)) PR_REG <= dat_i[16-1:0];

	reg [0:0] IM_REG;
	reg [0:0] IC_REG;
	reg [0:0] RIS_REG;

	wire[1-1:0]      MIS_REG	= RIS_REG & IM_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) IM_REG <= 0; else if(wb_we & (adr_i[16-1:0]==IM_REG_OFFSET)) IM_REG <= dat_i[1-1:0];
	always @(posedge clk_i or posedge rst_i) if(rst_i) IC_REG <= 1'b0;
                                        else if(wb_we & (adr_i[16-1:0]==IC_REG_OFFSET))
                                            IC_REG <= dat_i[1-1:0];
                                        else
                                            IC_REG <= 1'd0;

	wire [0:0] Done = done;


	integer _i_;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RIS_REG <= 0; else begin
		for(_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(Done[_i_ - 0] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
	end

	assign IRQ = |MIS_REG;

	EF_SPI #(
		.CLK_DIVIDER_WIDTH(CLK_DIVIDER_WIDTH)
	) instance_to_wrap (
		.clk(clk),
		.resetb(resetb),
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

	assign	dat_o = 
			(adr_i[16-1:0] == DATA_REG_OFFSET)	? DATA_WIRE :
			(adr_i[16-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(adr_i[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(adr_i[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(adr_i[16-1:0] == PR_REG_OFFSET)	? PR_REG :
			(adr_i[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(adr_i[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(adr_i[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(adr_i[16-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	always @ (posedge clk_i or posedge rst_i)
		if(rst_i)
			ack_o <= 1'b0;
		else if(wb_valid & ~ack_o)
			ack_o <= 1'b1;
		else
			ack_o <= 1'b0;
endmodule
