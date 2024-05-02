/*
	Copyright 2022 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)
	
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
/* 
    A wrapper around the spi_master module by Ubixum, Inc.
*/

`timescale        1ns/1ps
`default_nettype  none

module EF_SPI #(parameter 
                    CDW=8,
                    FAW=4
) (
    input               clk,
    input               rst_n,
    input               CPOL,
    input               CPHA,
    input  [CDW-1:0]    clk_divider,  
    input               wr,
    input               rd,      
    input  [7:0]        datai,
    output [7:0]        datao,
    
    input               rx_en,
    input               rx_flush,   
    input   [FAW-1:0]   rx_threshold,
    output              rx_empty,
    output              rx_full,
    output              rx_level_above,
    output  [FAW-1:0]   rx_level,
    
    input               tx_flush,
    input   [FAW-1:0]   tx_threshold,
    output              tx_empty,
    output              tx_full,
    output              tx_level_below,
    output  [FAW-1:0]   tx_level,

    //output              busy,
    //output              done,

    input               miso,
    output              mosi,
    output              csb,
    input               ss,
    output              sclk
);

    localparam FDW = 8;
    
    wire              busy;
    wire              done;

    // TX Side
    wire        tx_wr       = wr;
    wire        tx_rd       = !tx_empty & !busy;
    wire        spi_go      = !tx_empty & !busy;
    //wire        tx_empty;
    //wire [7:0]  datai;
    wire [7:0]  tx_wdata    = datai;
    wire [7:0]  tx_rdata;
    
    // RX Side
    wire        done_pe;
    wire        rx_wr       = rx_en & done_pe;
    wire        rx_rd       = rd;
    //wire        rx_empty;
    //wire [7:0]  datao;
    wire [7:0]  rx_wdata    = datao;
    wire [7:0]  rx_rdata;

    assign      tx_level_below = tx_level < tx_threshold;
    assign      rx_level_above = rx_level > rx_threshold;

    assign      csb = ~ss;
    
    aucohl_ped done_ed (
        .clk(clk),
        .in(done),
        .out(done_pe)
    );

    aucohl_fifo #(
        .DW(FDW), 
        .AW(FAW)
    ) rx_fifo (
        .clk(clk),
        .rst_n(rst_n),
        .rd(rx_rd),
        .wr(rx_wr),
        .flush(rx_flush),
        .wdata(rx_wdata),
        .empty(rx_empty),
        .full(rx_full),
        .rdata(rx_rdata),
        .level(rx_level)    
    );

    aucohl_fifo #(
        .DW(FDW), 
        .AW(FAW)
    ) tx_fifo (
        .clk(clk),
        .rst_n(rst_n),
        .rd(tx_rd),
        .wr(tx_wr),
        .flush(tx_flush),
        .wdata(tx_wdata),
        .empty(tx_empty),
        .full(tx_full),
        .rdata(tx_rdata),
        .level(tx_level)
    );

    spi_master#(
        .DATA_WIDTH(8),
        .CLK_DIVIDER_WIDTH(CDW),
        .NUM_PORTS(1),
        .SAMPLE_PHASE(0)
    ) spi_master (
        .clk(clk),
        .resetb(rst_n),
        .CPOL(CPOL),
        .CPHA(CPHA),
        .clk_divider(clk_divider),
        .go(spi_go),
        .datai(tx_rdata),
        .datao(datao),
        .busy(busy),
        .done(done),
        .dout(miso),
        .din(mosi),
        // .csb(csb),
        .sclk(sclk)
   );

endmodule


