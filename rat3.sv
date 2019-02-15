`timescale 1ns / 1ps

module REG_FILE(
    input [7:0]DIN,
    input [4:0]ADRX,
    input [4:0]ADRY,
    input RF_WR,
    input CLK,
    output [7:0]DX_OUT,
    output [7:0]DY_OUT
    );
    //32x8 RAM
    logic [7:0]ram[0:31];
    
    //clear RAM
    initial 
    begin
        for (int i=0; i<32; i++) 
            begin
            ram[i] = 8'b0;
            end
    end

    always @(posedge CLK)
    begin
        if (RF_WR)
            begin
            ram[ADRX] = DIN;
            end
    end

        assign DX_OUT = ram[ADRX];
        assign DY_OUT = ram[ADRY];

endmodule

module SCRATCH_RAM(
    input [9:0]DATA_IN,
    input [7:0]SCR_ADDR,
    input SCR_WE,
    input CLK,
    output [9:0]DATA_OUT
    );
    //256x10 RAM
    logic [9:0]ram[0:255];
    
    //clear RAM
    initial 
    begin
        for (int i=0; i<256; i++) 
            begin
            ram[i] = 10'b0;
            end
    end
    
    always @(posedge CLK)
    begin
        if (SCR_WE)
            begin
            ram[SCR_ADDR] = DATA_IN;
            end
    end

        assign DATA_OUT = ram[SCR_ADDR];
        
endmodule

module SCR_DataMux(
    input CLK,
    input SCR_DATA_SEL,
    input [7:0]DX_OUT,
    input [9:0]PC_COUNT,
    output reg [9:0]DATA_IN
    );
    
    always @(posedge CLK)
    begin
        case (SCR_DATA_SEL)
            1'b0:   DATA_IN = {1'b0,1'b0,DX_OUT[7],DX_OUT[6],DX_OUT[5],DX_OUT[4],DX_OUT[3],DX_OUT[2],DX_OUT[1],DX_OUT[0]};
            1'b1:   DATA_IN = PC_COUNT;
        endcase
    end
endmodule

module SCR_AddrMux(
    input CLK,
    input [1:0]SCR_ADDR_SEL,
    input [7:0]DY_OUT,
    input [7:0]IR,
    input [7:0]DATA_OUT,
    output reg [7:0]SCR_ADDR
    );
    
    always @(posedge CLK)
    begin
        case (SCR_ADDR_SEL)
            2'b00:  SCR_ADDR = DY_OUT;
            2'b01:  SCR_ADDR = IR;
            2'b10:  SCR_ADDR = DATA_OUT;
            2'b11:  SCR_ADDR = !DATA_OUT;
        endcase
    end

endmodule