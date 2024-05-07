/*
	Copyright 2023 Efabless Corp.

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

`define				AHBL_AW		16

`include			"ahbl_wrapper.vh"

module EF_SPI_AHBL #( 
	parameter	
		CDW = 8,
		FAW = 4
) (
	`AHBL_SLAVE_PORTS,
	input	[1-1:0]	miso,
	output	[1-1:0]	mosi,
	output	[1-1:0]	csb,
	output	[1-1:0]	sclk
);

	localparam	RXDATA_REG_OFFSET = `AHBL_AW'h0000;
	localparam	TXDATA_REG_OFFSET = `AHBL_AW'h0004;
	localparam	CFG_REG_OFFSET = `AHBL_AW'h0008;
	localparam	CTRL_REG_OFFSET = `AHBL_AW'h000C;
	localparam	PR_REG_OFFSET = `AHBL_AW'h0010;
	localparam	RX_FIFO_LEVEL_REG_OFFSET = `AHBL_AW'hFE00;
	localparam	RX_FIFO_THRESHOLD_REG_OFFSET = `AHBL_AW'hFE04;
	localparam	RX_FIFO_FLUSH_REG_OFFSET = `AHBL_AW'hFE08;
	localparam	TX_FIFO_LEVEL_REG_OFFSET = `AHBL_AW'hFE10;
	localparam	TX_FIFO_THRESHOLD_REG_OFFSET = `AHBL_AW'hFE14;
	localparam	TX_FIFO_FLUSH_REG_OFFSET = `AHBL_AW'hFE18;
	localparam	IM_REG_OFFSET = `AHBL_AW'hFF00;
	localparam	MIS_REG_OFFSET = `AHBL_AW'hFF04;
	localparam	RIS_REG_OFFSET = `AHBL_AW'hFF08;
	localparam	IC_REG_OFFSET = `AHBL_AW'hFF0C;
	wire		clk = HCLK;
	wire		rst_n = HRESETn;


	`AHBL_CTRL_SIGNALS

	wire [1-1:0]	CPOL;
	wire [1-1:0]	CPHA;
	wire [CDW-1:0]	clk_divider;
	wire [1-1:0]	wr;
	wire [1-1:0]	rd;
	wire [8-1:0]	datai;
	wire [8-1:0]	datao;
	wire [1-1:0]	rx_en;
	wire [1-1:0]	rx_flush;
	wire [FAW-1:0]	rx_threshold;
	wire [1-1:0]	rx_empty;
	wire [1-1:0]	rx_full;
	wire [1-1:0]	rx_level_above;
	wire [FAW-1:0]	rx_level;
	wire [1-1:0]	tx_flush;
	wire [FAW-1:0]	tx_threshold;
	wire [1-1:0]	tx_empty;
	wire [1-1:0]	tx_full;
	wire [1-1:0]	tx_level_below;
	wire [FAW-1:0]	tx_level;
	wire [1-1:0]	ss;

	// Register Definitions
	wire	[8-1:0]	RXDATA_WIRE;

	wire	[8-1:0]	TXDATA_WIRE;

	reg [1:0]	CFG_REG;
	assign	CPOL	=	CFG_REG[0 : 0];
	assign	CPHA	=	CFG_REG[1 : 1];
	`AHBL_REG(CFG_REG, 0, 2)

	reg [0:0]	CTRL_REG;
	assign	ss	=	CTRL_REG[1 : 1];
	`AHBL_REG(CTRL_REG, 0, 1)

	reg [CDW-1:0]	PR_REG;
	assign	clk_divider = PR_REG;
	`AHBL_REG(PR_REG, 'h2, CDW)

	wire [FAW-1:0]	RX_FIFO_LEVEL_WIRE;
	assign	RX_FIFO_LEVEL_WIRE[(FAW - 1) : 0] = rx_level;

	reg [0:0]	RX_FIFO_THRESHOLD_REG;
	assign	rx_threshold	=	RX_FIFO_THRESHOLD_REG[0 : 0];
	`AHBL_REG(RX_FIFO_THRESHOLD_REG, 0, 1)

	reg [0:0]	RX_FIFO_FLUSH_REG;
	assign	rx_flush	=	RX_FIFO_FLUSH_REG[0 : 0];
	`AHBL_REG_AC(RX_FIFO_FLUSH_REG, 0, 1, 1'h0)

	wire [FAW-1:0]	TX_FIFO_LEVEL_WIRE;
	assign	TX_FIFO_LEVEL_WIRE[(FAW - 1) : 0] = tx_level;

	reg [0:0]	TX_FIFO_THRESHOLD_REG;
	assign	tx_threshold	=	TX_FIFO_THRESHOLD_REG[0 : 0];
	`AHBL_REG(TX_FIFO_THRESHOLD_REG, 0, 1)

	reg [0:0]	TX_FIFO_FLUSH_REG;
	assign	tx_flush	=	TX_FIFO_FLUSH_REG[0 : 0];
	`AHBL_REG_AC(TX_FIFO_FLUSH_REG, 0, 1, 1'h0)

	reg [5:0] IM_REG;
	reg [5:0] IC_REG;
	reg [5:0] RIS_REG;

	`AHBL_MIS_REG(6)
	`AHBL_REG(IM_REG, 0, 6)
	`AHBL_IC_REG(6)

	wire [0:0] TXE = tx_empty;
	wire [0:0] TXF = tx_full;
	wire [0:0] RXF = rx_empty;
	wire [0:0] RXF = rx_full;
	wire [0:0] TXB = tx_level_below;
	wire [0:0] RXA = rx_level_above;


	integer _i_;
	`AHBL_BLOCK(RIS_REG, 0) else begin
		for(_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(TXE[_i_ - 0] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(TXF[_i_ - 1] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 2; _i_ < 3; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(RXF[_i_ - 2] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 3; _i_ < 4; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(RXF[_i_ - 3] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 4; _i_ < 5; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(TXB[_i_ - 4] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 5; _i_ < 6; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(RXA[_i_ - 5] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
	end

	assign IRQ = |MIS_REG;

	EF_SPI #(
		.CDW(CDW),
		.FAW(FAW)
	) instance_to_wrap (
		.clk(clk),
		.rst_n(rst_n),
		.CPOL(CPOL),
		.CPHA(CPHA),
		.clk_divider(clk_divider),
		.wr(wr),
		.rd(rd),
		.datai(datai),
		.datao(datao),
		.rx_en(rx_en),
		.rx_flush(rx_flush),
		.rx_threshold(rx_threshold),
		.rx_empty(rx_empty),
		.rx_full(rx_full),
		.rx_level_above(rx_level_above),
		.rx_level(rx_level),
		.tx_flush(tx_flush),
		.tx_threshold(tx_threshold),
		.tx_empty(tx_empty),
		.tx_full(tx_full),
		.tx_level_below(tx_level_below),
		.tx_level(tx_level),
		.ss(ss),
		.miso(miso),
		.mosi(mosi),
		.csb(csb),
		.sclk(sclk)
	);

	assign	HRDATA = 
			(last_HADDR[`AHBL_AW-1:0] == RXDATA_REG_OFFSET)	? RXDATA_WIRE :
			(last_HADDR[`AHBL_AW-1:0] == TXDATA_REG_OFFSET)	? TXDATA_WIRE :
			(last_HADDR[`AHBL_AW-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(last_HADDR[`AHBL_AW-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(last_HADDR[`AHBL_AW-1:0] == PR_REG_OFFSET)	? PR_REG :
			(last_HADDR[`AHBL_AW-1:0] == RX_FIFO_LEVEL_REG_OFFSET)	? RX_FIFO_LEVEL_WIRE :
			(last_HADDR[`AHBL_AW-1:0] == RX_FIFO_THRESHOLD_REG_OFFSET)	? RX_FIFO_THRESHOLD_REG :
			(last_HADDR[`AHBL_AW-1:0] == RX_FIFO_FLUSH_REG_OFFSET)	? RX_FIFO_FLUSH_REG :
			(last_HADDR[`AHBL_AW-1:0] == TX_FIFO_LEVEL_REG_OFFSET)	? TX_FIFO_LEVEL_WIRE :
			(last_HADDR[`AHBL_AW-1:0] == TX_FIFO_THRESHOLD_REG_OFFSET)	? TX_FIFO_THRESHOLD_REG :
			(last_HADDR[`AHBL_AW-1:0] == TX_FIFO_FLUSH_REG_OFFSET)	? TX_FIFO_FLUSH_REG :
			(last_HADDR[`AHBL_AW-1:0] == IM_REG_OFFSET)	? IM_REG :
			(last_HADDR[`AHBL_AW-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(last_HADDR[`AHBL_AW-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(last_HADDR[`AHBL_AW-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	assign	HREADYOUT = 1'b1;

	assign	RXDATA_WIRE = datao;
	assign	rd = (ahbl_re & (last_HADDR[`AHBL_AW-1:0] == RXDATA_REG_OFFSET));
	assign	wdata = HWDATA;
	assign	wr = (ahbl_we & (last_HADDR[`AHBL_AW-1:0] == TXDATA_REG_OFFSET));
endmodule
