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






                                        



































module EF_SPI_APB #( 
	parameter	
		CLK_DIVIDER_WIDTH = 8
) (
	input wire          PCLK,
                                        input wire          PRESETn,
                                        input wire          PWRITE,
                                        input wire [31:0]   PWDATA,
                                        input wire [31:0]   PADDR,
                                        input wire          PENABLE,
                                        input wire          PSEL,
                                        output wire         PREADY,
                                        output wire [31:0]  PRDATA,
                                        output wire         IRQ
,
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

	wire		clk = PCLK;
	wire		resetb = PRESETn;


	wire		apb_valid   = PSEL & PENABLE;
                                        wire		apb_we	    = PWRITE & apb_valid;
                                        wire		apb_re	    = ~PWRITE & apb_valid;

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
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) DATA_REG <= 0;
                                        else if(apb_we & (PADDR[16-1:0]==DATA_REG_OFFSET))
                                            DATA_REG <= PWDATA[8-1:0];

	reg [1:0]	CFG_REG;
	assign	CPOL	=	CFG_REG[0 : 0];
	assign	CPHA	=	CFG_REG[1 : 1];
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) CFG_REG <= 0;
                                        else if(apb_we & (PADDR[16-1:0]==CFG_REG_OFFSET))
                                            CFG_REG <= PWDATA[2-1:0];

	wire [2-1:0]	STATUS_WIRE;
	assign	STATUS_WIRE[0 : 0] = done;
	assign	STATUS_WIRE[1 : 1] = busy;

	reg [1:0]	CTRL_REG;
	assign	go	=	CTRL_REG[0 : 0];
	assign	ss	=	CTRL_REG[1 : 1];
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) CTRL_REG <= 0;
                                                else if(apb_we & (PADDR[16-1:0]==CTRL_REG_OFFSET))
                                                    CTRL_REG <= PWDATA[2-1:0];
                                                else
                                                    CTRL_REG <= 2'h2 & CTRL_REG;

	reg [15:0]	PR_REG;
	assign	clk_divider = PR_REG;
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) PR_REG <= 'h2;
                                        else if(apb_we & (PADDR[16-1:0]==PR_REG_OFFSET))
                                            PR_REG <= PWDATA[16-1:0];

	reg [0:0] IM_REG;
	reg [0:0] IC_REG;
	reg [0:0] RIS_REG;

	wire[1-1:0]      MIS_REG	= RIS_REG & IM_REG;
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) IM_REG <= 0;
                                        else if(apb_we & (PADDR[16-1:0]==IM_REG_OFFSET))
                                            IM_REG <= PWDATA[1-1:0];
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) IC_REG <= 1'b0;
                                        else if(apb_we & (PADDR[16-1:0]==IC_REG_OFFSET))
                                            IC_REG <= PWDATA[1-1:0];
                                        else
                                            IC_REG <= 1'd0;

	wire [0:0] Done = done;


	integer _i_;
	always @(posedge PCLK or negedge PRESETn) if(~PRESETn) RIS_REG <= 0; else begin
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

	assign	PRDATA = 
			(PADDR[16-1:0] == DATA_REG_OFFSET)	? DATA_WIRE :
			(PADDR[16-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(PADDR[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[16-1:0] == PR_REG_OFFSET)	? PR_REG :
			(PADDR[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[16-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	assign	PREADY = 1'b1;

endmodule
