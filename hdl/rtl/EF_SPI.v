// wrapper for passing the spi master module
 module EF_SPI #(parameter CDW=8) (
    input               clk,
    input               rst_n,
    input               CPOL,
    input               CPHA,
    input  [CDW-1:0]    clk_divider,  
    input               go,
    input  [7:0]        datai,
    output [7:0]        datao,
    output              busy,
    output              done,    
    input               dout,
    output              din,
    output              csb,
    input               ss,
    output              sclk
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
      .go(go),
      .datai(datai),
      .datao(datao),
      .busy(busy),
      .done(done),
      .dout(dout),
      .din(din),
      // .csb(csb),
      .sclk(sclk)
   );
   assign csb = ~ss;
endmodule
