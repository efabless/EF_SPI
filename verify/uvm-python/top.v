`timescale 1ns/1ps

module top();
    reg 		CLK = 0;
    wire 		RESETn = 1;
    wire 		irq;
    // TODO: Add any IP signals here
    wire [31:0]	PADDR;
    wire 		PWRITE;
    wire 		PSEL;
    wire 		PENABLE;
    wire [31:0]	PWDATA;
    wire [31:0]	PRDATA;
    wire 		PREADY;
    wire         MSI;
    wire         MSO;
    wire         SSn;
    wire         SCK;
    // TODO: initialize the ABP wrapper here
    // for example
    EF_SPI_APB dut(.PCLK(CLK), .PRESETn(RESETn), .PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .MSI(MSI), .MSO(MSO), .SSn(SSn), .SCK(SCK), IRQ(irq));
    // monitor inside signals
    `ifndef SKIP_WAVE_DUMP
        initial begin
            $dumpfile ({"waves.vcd"});
            $dumpvars(0, top);
        end
    `endif
    always #10 CLK = !CLK; // clk generator
endmodule