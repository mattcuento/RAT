`timescale 1ns / 1ps

module ProgramCounter_tb;
    //MUX
    logic [9:0]FROM_IMMED;  //in
    logic [9:0]FROM_STACK;  //in
    logic [1:0]PC_MUX_SEL;  //in
    logic CLK;              //in mux/PC, out clk
    logic [9:0]MUX_O;       //out mux
    //PC
    logic PC_LD;            //in
    logic PC_INC;           //in
    logic RST;              //in
    logic [9:0]PC_COUNT;     //out PC
    
    clk clk0(.*);
    PC_Mux mux0(.*);
    ProgramCounter PC0(
        .PC_LD(PC_LD),
        .PC_INC(PC_INC),
        .D_IN(MUX_O),
        .RST(RST),
        .CLK(CLK),
        .PC_COUNT(PC_COUNT)
        );
        
    initial
        begin
        FROM_IMMED = 10'hFF8;
        FROM_STACK = 10'h003;
        
        for (int i=0;i<3;i++)
            begin
            PC_MUX_SEL = i;
            for (logic [2:0]j=3'b000;j<3'b111;j++)
                begin
                PC_LD = j[0];
                PC_INC = j[1];
                RST = j[2];
                #10;
                end
            //#10;
            end 
        end

        
endmodule
