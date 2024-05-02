`include "tb_macros.vh"
module EF_SPI_tb;
    localparam CDW = 8;
    localparam FAW = 4;
    
    //reg             clk;
    //reg             rst_n;
    reg             CPOL = 0;
    reg             CPHA = 0;
    reg  [CDW-1:0]  clk_divider = 10;  
    reg             wr = 0;
    reg             rd = 0;
    reg  [7:0]      datai;
    wire [7:0]      datao;
    wire            busy;
    wire            done;    
    wire            mosi;
    wire            miso;
    wire            csb;
    reg             ss = 0;
    wire            sclk;
    
    reg               rx_en;
    reg               rx_flush = 0;
    reg   [FAW-1:0]   rx_threshold;
    wire  [FAW-1:0]   rx_level;
    
    reg               tx_flush = 0;
    reg   [FAW-1:0]   tx_threshold;
    wire  [FAW-1:0]   tx_level;

    // Create a loopback
    assign miso = mosi;

    EF_SPI MUV (
        .clk(clk),
        .rst_n(rst_n),
        .CPOL(CPOL),
        .CPHA(CPHA),
        .clk_divider(clk_divider),
        .wr(wr),
        .rd(rd),
        .datai(datai),
        .datao(datao),
        //.busy(busy),
        //.done(done),
        .rx_en(rx_en),
        .rx_flush(rx_flush),
        .tx_flush(tx_flush),
        .miso(miso),
        .mosi(mosi),
        .csb(csb),
        .ss(ss),
        .sclk(sclk)
    );

    `TB_CLK(clk, 5)
    `TB_SRSTN(rst_n, clk, 387)
    `TB_DUMP("EF_SPI_tb.vcd", EF_SPI_tb, 0) 
    `TB_FINISH(100_000)

    initial begin
        @(posedge rst_n);
        #999;

        rx_en = 1;

        @(posedge clk);
        ss = 1;

        @(posedge clk);
        datai = 8'h35;
        #1;
        wr = 1'b1;
        
        @(posedge clk);
        #1;
        wr = 1'b0;

        @(posedge clk);
        datai = 8'h93;
        #1;
        wr = 1'b1;
        
        @(posedge clk);
        #1;
        wr = 1'b0;

        
        //@(posedge done);
        //ss = 1;
        
        #1_500;
        $finish;
    end

endmodule
