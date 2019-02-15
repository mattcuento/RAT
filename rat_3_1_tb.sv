`timescale 1ns / 1ps

module rat_3_1_tb;
    logic [7:0]DIN;         //in data
    logic [4:0]ADRX;        //in address x
    logic [4:0]ADRY;        //in address y
    logic RF_WR;            //in (control)
    logic CLK;              //in (clock)
    logic [7:0]DX_OUT;      //out x
    logic [7:0]DY_OUT;      //out y
    
    clk clk0(.*);
    REG_FILE regF(.*);
    
    initial
    begin
    DIN=8'h0A;
    ADRX=5'b11111;
    ADRY=5'b00000;
    RF_WR=1'b1;
    #10;
    
    DIN=8'h07;
    ADRX=5'b00011;
    ADRY=5'b00001;
    RF_WR=1'b1;
    #10;
    
    DIN=8'h0F;
    ADRX=5'b11111;
    ADRY=5'b00011;
    RF_WR=1'b0;
    #10;

    DIN=8'h0F;
    ADRX=5'b10101;
    ADRY=5'b11111;
    RF_WR=1'b1;
    #10;
    
    DIN=8'hF0;
    ADRX=5'b01010;
    ADRY=5'b00011;
    RF_WR=1'b1;
    #10;
    
    DIN=8'hAA;
    ADRX=5'b10101;
    ADRY=5'b01010;
    RF_WR=1'b0;
    #10;
    end

endmodule

module rat_3_2_tb;
/*input [9:0]DATA_IN,
    input [7:0]SCR_ADDR,
    input SCR_WE,
    input CLK,
    output [9:0]DATA_OUT
    */
    logic [9:0]DATA_IN;
    logic [7:0]SCR_ADDR;
    logic SCR_WE;
    logic CLK;
    logic [9:0]DATA_OUT;
    
    clk clk0(.*);
    SCRATCH_RAM scrR(.*);
    
    initial
    begin
    DATA_IN=10'h214;
    SCR_ADDR=8'b1000100;
    SCR_WE=1'b1;
    #10;

    DATA_IN=10'h0FF;
    SCR_ADDR=8'b10101010;
    SCR_WE=1'b1;
    #10;
    
    DATA_IN=10'h0B8;
    SCR_ADDR=8'b00100001;
    SCR_WE=1'b0;
    #10;
    
    DATA_IN=10'h32C;
    SCR_ADDR=8'b1111111;
    SCR_WE=1'b1;
    #10;

    DATA_IN=10'h081;
    SCR_ADDR=8'b00100010;
    SCR_WE=1'b0;
    #10;
    
    DATA_IN=10'h115;
    SCR_ADDR=8'b00110100;
    SCR_WE=1'b0;
    #10;
    end
    
endmodule