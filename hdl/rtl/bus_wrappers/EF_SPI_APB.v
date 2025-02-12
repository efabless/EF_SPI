/*
	Copyright 2025 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale 1ns / 1ps
`default_nettype none

module EF_SPI_APB #(
    parameter CDW = 8,
    FAW = 4
) (

    input  wire         PCLK,
    input  wire         PRESETn,
    input  wire         PWRITE,
    input  wire [ 31:0] PWDATA,
    input  wire [ 31:0] PADDR,
    input  wire         PENABLE,
    input  wire         PSEL,
    output wire         PREADY,
    output wire [ 31:0] PRDATA,
    output wire         IRQ,
    input  wire [1-1:0] miso,
    output wire [1-1:0] mosi,
    output wire [1-1:0] csb,
    output wire [1-1:0] sclk
);

  localparam RXDATA_REG_OFFSET = 16'h0000;
  localparam TXDATA_REG_OFFSET = 16'h0004;
  localparam CFG_REG_OFFSET = 16'h0008;
  localparam CTRL_REG_OFFSET = 16'h000C;
  localparam PR_REG_OFFSET = 16'h0010;
  localparam STATUS_REG_OFFSET = 16'h0014;
  localparam RX_FIFO_LEVEL_REG_OFFSET = 16'hFE00;
  localparam RX_FIFO_THRESHOLD_REG_OFFSET = 16'hFE04;
  localparam RX_FIFO_FLUSH_REG_OFFSET = 16'hFE08;
  localparam TX_FIFO_LEVEL_REG_OFFSET = 16'hFE10;
  localparam TX_FIFO_THRESHOLD_REG_OFFSET = 16'hFE14;
  localparam TX_FIFO_FLUSH_REG_OFFSET = 16'hFE18;
  localparam IM_REG_OFFSET = 16'hFF00;
  localparam MIS_REG_OFFSET = 16'hFF04;
  localparam RIS_REG_OFFSET = 16'hFF08;
  localparam IC_REG_OFFSET = 16'hFF0C;

  reg [0:0] GCLK_REG;
  wire clk_g;

  wire clk_gated_en = GCLK_REG[0];
  ef_util_gating_cell clk_gate_cell (

      // USE_POWER_PINS
      .clk(PCLK),
      .clk_en(clk_gated_en),
      .clk_o(clk_g)
  );

  wire           clk = clk_g;
  wire           rst_n = PRESETn;

  wire           apb_valid = PSEL & PENABLE;
  wire           apb_we = PWRITE & apb_valid;
  wire           apb_re = ~PWRITE & apb_valid;

  wire [  1-1:0] CPOL;
  wire [  1-1:0] CPHA;
  wire [CDW-1:0] clk_divider;
  wire [  1-1:0] wr;
  wire [  1-1:0] rd;
  wire [  8-1:0] datai;
  wire [  8-1:0] datao;
  wire [  1-1:0] rx_en;
  wire [  1-1:0] rx_flush;
  wire [FAW-1:0] rx_threshold;
  wire [  1-1:0] rx_empty;
  wire [  1-1:0] rx_full;
  wire [  1-1:0] rx_level_above;
  wire [FAW-1:0] rx_level;
  wire [  1-1:0] tx_flush;
  wire [FAW-1:0] tx_threshold;
  wire [  1-1:0] tx_empty;
  wire [  1-1:0] tx_full;
  wire [  1-1:0] tx_level_below;
  wire [FAW-1:0] tx_level;
  wire [  1-1:0] ss;
  wire [  1-1:0] enable;
  wire [  1-1:0] done;
  wire [  1-1:0] busy;

  // Register Definitions
  wire [  8-1:0] RXDATA_WIRE;

  reg  [    1:0] CFG_REG;
  assign CPOL = CFG_REG[0 : 0];
  assign CPHA = CFG_REG[1 : 1];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) CFG_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == CFG_REG_OFFSET)) CFG_REG <= PWDATA[2-1:0];

  reg [2:0] CTRL_REG;
  assign ss = CTRL_REG[0 : 0];
  assign enable = CTRL_REG[1 : 1];
  assign rx_en = CTRL_REG[2 : 2];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) CTRL_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == CTRL_REG_OFFSET)) CTRL_REG <= PWDATA[3-1:0];

  reg [CDW-1:0] PR_REG;
  assign clk_divider = PR_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) PR_REG <= 'h2;
    else if (apb_we & (PADDR[16-1:0] == PR_REG_OFFSET)) PR_REG <= PWDATA[CDW-1:0];

  wire [8-1:0] STATUS_WIRE;
  assign STATUS_WIRE[0 : 0] = tx_empty;
  assign STATUS_WIRE[1 : 1] = tx_full;
  assign STATUS_WIRE[2 : 2] = rx_empty;
  assign STATUS_WIRE[3 : 3] = rx_full;
  assign STATUS_WIRE[4 : 4] = tx_level_below;
  assign STATUS_WIRE[5 : 5] = rx_level_above;
  assign STATUS_WIRE[6 : 6] = busy;
  assign STATUS_WIRE[7 : 7] = done;

  wire [FAW-1:0] RX_FIFO_LEVEL_WIRE;
  assign RX_FIFO_LEVEL_WIRE[(FAW-1) : 0] = rx_level;

  reg [FAW-1:0] RX_FIFO_THRESHOLD_REG;
  assign rx_threshold = RX_FIFO_THRESHOLD_REG[(FAW-1) : 0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RX_FIFO_THRESHOLD_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RX_FIFO_THRESHOLD_REG_OFFSET))
      RX_FIFO_THRESHOLD_REG <= PWDATA[FAW-1:0];

  reg [0:0] RX_FIFO_FLUSH_REG;
  assign rx_flush = RX_FIFO_FLUSH_REG[0 : 0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RX_FIFO_FLUSH_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RX_FIFO_FLUSH_REG_OFFSET))
      RX_FIFO_FLUSH_REG <= PWDATA[1-1:0];
    else RX_FIFO_FLUSH_REG <= 1'h0 & RX_FIFO_FLUSH_REG;

  wire [FAW-1:0] TX_FIFO_LEVEL_WIRE;
  assign TX_FIFO_LEVEL_WIRE[(FAW-1) : 0] = tx_level;

  reg [FAW-1:0] TX_FIFO_THRESHOLD_REG;
  assign tx_threshold = TX_FIFO_THRESHOLD_REG[(FAW-1) : 0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) TX_FIFO_THRESHOLD_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == TX_FIFO_THRESHOLD_REG_OFFSET))
      TX_FIFO_THRESHOLD_REG <= PWDATA[FAW-1:0];

  reg [0:0] TX_FIFO_FLUSH_REG;
  assign tx_flush = TX_FIFO_FLUSH_REG[0 : 0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) TX_FIFO_FLUSH_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == TX_FIFO_FLUSH_REG_OFFSET))
      TX_FIFO_FLUSH_REG <= PWDATA[1-1:0];
    else TX_FIFO_FLUSH_REG <= 1'h0 & TX_FIFO_FLUSH_REG;

  localparam GCLK_REG_OFFSET = 16'hFF10;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) GCLK_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == GCLK_REG_OFFSET)) GCLK_REG <= PWDATA[1-1:0];

  reg  [  5:0] IM_REG;
  reg  [  5:0] IC_REG;
  reg  [  5:0] RIS_REG;

  wire [6-1:0] MIS_REG = RIS_REG & IM_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) IM_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == IM_REG_OFFSET)) IM_REG <= PWDATA[6-1:0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) IC_REG <= 6'b0;
    else if (apb_we & (PADDR[16-1:0] == IC_REG_OFFSET)) IC_REG <= PWDATA[6-1:0];
    else IC_REG <= 6'd0;

  wire [0:0] TXE = tx_empty;
  wire [0:0] TXF = tx_full;
  wire [0:0] RXE = rx_empty;
  wire [0:0] RXF = rx_full;
  wire [0:0] TXB = tx_level_below;
  wire [0:0] RXA = rx_level_above;

  integer _i_;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RIS_REG <= 0;
    else begin
      for (_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (TXE[_i_-0] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (TXF[_i_-1] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 2; _i_ < 3; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (RXE[_i_-2] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 3; _i_ < 4; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (RXF[_i_-3] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 4; _i_ < 5; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (TXB[_i_-4] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 5; _i_ < 6; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (RXA[_i_-5] == 1'b1) RIS_REG[_i_] <= 1'b1;
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
      .enable(enable),
      .done(done),
      .busy(busy),
      .miso(miso),
      .mosi(mosi),
      .csb(csb),
      .sclk(sclk)
  );

  assign	PRDATA = 
			(PADDR[16-1:0] == RXDATA_REG_OFFSET)	? RXDATA_WIRE :
			(PADDR[16-1:0] == CFG_REG_OFFSET)	? CFG_REG :
			(PADDR[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[16-1:0] == PR_REG_OFFSET)	? PR_REG :
			(PADDR[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[16-1:0] == RX_FIFO_LEVEL_REG_OFFSET)	? RX_FIFO_LEVEL_WIRE :
			(PADDR[16-1:0] == RX_FIFO_THRESHOLD_REG_OFFSET)	? RX_FIFO_THRESHOLD_REG :
			(PADDR[16-1:0] == RX_FIFO_FLUSH_REG_OFFSET)	? RX_FIFO_FLUSH_REG :
			(PADDR[16-1:0] == TX_FIFO_LEVEL_REG_OFFSET)	? TX_FIFO_LEVEL_WIRE :
			(PADDR[16-1:0] == TX_FIFO_THRESHOLD_REG_OFFSET)	? TX_FIFO_THRESHOLD_REG :
			(PADDR[16-1:0] == TX_FIFO_FLUSH_REG_OFFSET)	? TX_FIFO_FLUSH_REG :
			(PADDR[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[16-1:0] == GCLK_REG_OFFSET)	? GCLK_REG :
			32'hDEADBEEF;

  assign PREADY = 1'b1;

  assign RXDATA_WIRE = datao;
  assign rd = (apb_re & (PADDR[16-1:0] == RXDATA_REG_OFFSET));
  assign datai = PWDATA;
  assign wr = (apb_we & (PADDR[16-1:0] == TXDATA_REG_OFFSET));
endmodule
