`timescale 1ns / 1ps

module rat1_2_tb;
    logic PROG_CLK;
    logic [9:0]PROG_ADDR;
    logic [17:0]PROG_IR;
    
    ProgRom test(.PROG_CLK(PROG_CLK),.PROG_ADDR(PROG_ADDR),.PROG_IR(PROG_IR));
    
initial
    begin
    PROG_CLK = 0;
    PROG_ADDR = 'h3F;
    end
    
always 
    begin
    PROG_CLK = !PROG_CLK;
    #1;
    end
    
always @(posedge PROG_CLK)
    begin
    if (PROG_ADDR < 'h48)
        begin
        PROG_ADDR++;
        end
    else
        begin
        PROG_ADDR = 'h40;
        end
    end
endmodule
