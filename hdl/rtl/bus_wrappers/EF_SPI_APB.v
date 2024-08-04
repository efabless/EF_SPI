/*
	Copyright 2024 Efabless Corp.

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
		CDW = 8,
		FAW = 4
) (
`ifdef USE_POWER_PINS
	inout VPWR,
	inout VGND,
`endif
	`APB_SLAVE_PORTS,
	input	wire	[1-1:0]	miso,
	output	wire	[1-1:0]	mosi,
	output	wire	[1-1:0]	csb,
	output	wire	[1-1:0]	sclk
);

	localparam	RXDATA_REG_OFFSET = `APB_AW'h0000;
	localparam	TXDATA_REG_OFFSET = `APB_AW'h0004;
	localparam	CFG_REG_OFFSET = `APB_AW'h0008;
	localparam	CTRL_REG_OFFSET = `APB_AW'h000C;
	localparam	PR_REG_OFFSET = `APB_AW'h0010;
	localparam	STATUS_REG_OFFSET = `APB_AW'h0014;
	localparam	RX_FIFO_LEVEL_REG_OFFSET = `APB_AW'hFE00;
	localparam	RX_FIFO_THRESHOLD_REG_OFFSET = `APB_AW'hFE04;
	localparam	RX_FIFO_FLUSH_REG_OFFSET = `APB_AW'hFE08;
	localparam	TX_FIFO_LEVEL_REG_OFFSET = `APB_AW'hFE10;
	localparam	TX_FIFO_THRESHOLD_REG_OFFSET = `APB_AW'hFE14;
	localparam	TX_FIFO_FLUSH_REG_OFFSET = `APB_AW'hFE18;
	localparam	IM_REG_OFFSET = `APB_AW'hFF00;
	localparam	MIS_REG_OFFSET = `APB_AW'hFF04;
	localparam	RIS_REG_OFFSET = `APB_AW'hFF08;
	localparam	IC_REG_OFFSET = `APB_AW'hFF0C;

        reg [0:0] GCLK_REG;
        wire clk_g;
        wire clk_gated_en = GCLK_REG[0];

    (* keep *) sky130_fd_sc_hd__dlclkp_4 clk_gate(
    `ifdef USE_POWER_PINS 
        .VPWR(VPWR), 
        .VGND(VGND), 
        .VNB(VGND),
		.VPB(VPWR),
    `endif 
        .GCLK(clk_g), 
        .GATE(clk_gated_en), 
        .CLK(PCLK)
        );
        
	wire		clk = clk_g;
	wire		rst_n = PRESETn;


	`APB_CTRL_SIGNALS

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
	wire [1-1:0]	enable;

	// Register Definitions
	wire	[8-1:0]	RXDATA_WIRE;

	wire	[8-1:0]	TXDATA_WIRE;

	reg [1:0]	CFG_REG;
	assign	CPOL	=	CFG_REG[0 : 0];
	assign	CPHA	=	CFG_REG[1 : 1];
	`APB_REG(CFG_REG, 0, 2)

	reg [2:0]	CTRL_REG;
	assign	ss	=	CTRL_REG[0 : 0];
	assign	enable	=	CTRL_REG[1 : 1];
	assign	rx_en	=	CTRL_REG[2 : 2];
	`APB_REG(CTRL_REG, 0, 3)

	reg [CDW-1:0]	PR_REG;
	assign	clk_divider = PR_REG;
	`APB_REG(PR_REG, 'h2, CDW)

	wire [6-1:0]	STATUS_WIRE;
	assign	STATUS_WIRE[0 : 0] = tx_empty;
	assign	STATUS_WIRE[1 : 1] = tx_full;
	assign	STATUS_WIRE[2 : 2] = rx_empty;
	assign	STATUS_WIRE[3 : 3] = rx_full;
	assign	STATUS_WIRE[4 : 4] = tx_level_below;
	assign	STATUS_WIRE[5 : 5] = rx_level_above;

	wire [FAW-1:0]	RX_FIFO_LEVEL_WIRE;
	assign	RX_FIFO_LEVEL_WIRE[(FAW - 1) : 0] = rx_level;

	reg [FAW-1:0]	RX_FIFO_THRESHOLD_REG;
	assign	rx_threshold	=	RX_FIFO_THRESHOLD_REG[(FAW - 1) : 0];
	`APB_REG(RX_FIFO_THRESHOLD_REG, 0, FAW)

	reg [0:0]	RX_FIFO_FLUSH_REG;
	assign	rx_flush	=	RX_FIFO_FLUSH_REG[0 : 0];
	`APB_REG_AC(RX_FIFO_FLUSH_REG, 0, 1, 1'h0)

	wire [FAW-1:0]	TX_FIFO_LEVEL_WIRE;
	assign	TX_FIFO_LEVEL_WIRE[(FAW - 1) : 0] = tx_level;

	reg [FAW-1:0]	TX_FIFO_THRESHOLD_REG;
	assign	tx_threshold	=	TX_FIFO_THRESHOLD_REG[(FAW - 1) : 0];
	`APB_REG(TX_FIFO_THRESHOLD_REG, 0, FAW)

	reg [0:0]	TX_FIFO_FLUSH_REG;
	assign	tx_flush	=	TX_FIFO_FLUSH_REG[0 : 0];
	`APB_REG_AC(TX_FIFO_FLUSH_REG, 0, 1, 1'h0)

	localparam	GCLK_REG_OFFSET = `APB_AW'hFF10;
	`APB_REG(GCLK_REG, 0, 1)

	reg [5:0] IM_REG;
	reg [5:0] IC_REG;
	reg [5:0] RIS_REG;

	`APB_MIS_REG(6)
	`APB_REG(IM_REG, 0, 6)
	`APB_IC_REG(6)

	wire [0:0] TXE = tx_empty;
	wire [0:0] TXF = tx_full;
	wire [0:0] RXE = rx_empty;
	wire [0:0] RXF = rx_full;
	wire [0:0] TXB = tx_level_below;
	wire [0:0] RXA = rx_level_above;


	integer _i_;
	`APB_BLOCK(RIS_REG, 0) else begin
		for(_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(TXE[_i_ - 0] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(TXF[_i_ - 1] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 2; _i_ < 3; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(RXE[_i_ - 2] == 1'b1) RIS_REG[_i_] <= 1'b1;
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

	reg [0:0]	_miso_reg_[1:0];
	wire		_miso_w_ = _miso_reg_[1];
	always@(posedge PCLK or negedge PRESETn)
		if(PRESETn == 0) begin
			_miso_reg_[0] <= 'b0;
			_miso_reg_[1] <= 'b0;
		end
		else begin
			_miso_reg_[0] <= miso;
			_miso_reg_[1] <= _miso_reg_[0];
		end
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
		.enable(enable),
		.miso(_miso_w_),
		.mosi(mosi),
		.csb(csb),
		.sclk(sclk)
	);

	assign	PRDATA = 
			(PADDR[`APB_AW-1:0] == RXDATA_REG_OFFSET)	? RXDATA_WIRE :
			(PADDR[`APB_AW-1:0] == TXDATA_REG_OFFSET)	? TXDATA_WIRE :
			(PADDR[`APB_AW-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(PADDR[`APB_AW-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[`APB_AW-1:0] == PR_REG_OFFSET)	? PR_REG :
			(PADDR[`APB_AW-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[`APB_AW-1:0] == RX_FIFO_LEVEL_REG_OFFSET)	? RX_FIFO_LEVEL_WIRE :
			(PADDR[`APB_AW-1:0] == RX_FIFO_THRESHOLD_REG_OFFSET)	? RX_FIFO_THRESHOLD_REG :
			(PADDR[`APB_AW-1:0] == RX_FIFO_FLUSH_REG_OFFSET)	? RX_FIFO_FLUSH_REG :
			(PADDR[`APB_AW-1:0] == TX_FIFO_LEVEL_REG_OFFSET)	? TX_FIFO_LEVEL_WIRE :
			(PADDR[`APB_AW-1:0] == TX_FIFO_THRESHOLD_REG_OFFSET)	? TX_FIFO_THRESHOLD_REG :
			(PADDR[`APB_AW-1:0] == TX_FIFO_FLUSH_REG_OFFSET)	? TX_FIFO_FLUSH_REG :
			(PADDR[`APB_AW-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[`APB_AW-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[`APB_AW-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[`APB_AW-1:0] == IC_REG_OFFSET)	? IC_REG :
			(PADDR[`APB_AW-1:0] == GCLK_REG_OFFSET)	? GCLK_REG :
			32'hDEADBEEF;

	assign	PREADY = 1'b1;

	assign	RXDATA_WIRE = datao;
	assign	rd = (apb_re & (PADDR[`APB_AW-1:0] == RXDATA_REG_OFFSET));
	assign	datai = PWDATA;
	assign	wr = (apb_we & (PADDR[`APB_AW-1:0] == TXDATA_REG_OFFSET));
endmodule
