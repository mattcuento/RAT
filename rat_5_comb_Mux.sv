`timescale 1ns / 1ps

module comb_PC_Mux(
    input [9:0]FROM_IMMED,
    input [9:0]FROM_STACK,
    input [1:0]PC_MUX_SEL,
    output [9:0]MUX_O
    );
    
    logic [9:0]T_MUX_O;
    
    always_comb
    begin
        case (PC_MUX_SEL)
            2'b00:  T_MUX_O <= FROM_IMMED;
            2'b01:  T_MUX_O <= FROM_STACK;
            2'b10:  T_MUX_O <= 10'h3FF;
            default:  T_MUX_O<=10'h000;
        endcase
    end 
    
    assign MUX_O=T_MUX_O;
    
endmodule

module comb_RF_Mux(
    input [1:0]RF_WR_SEL,
    input [7:0]RESULT,
    input [7:0]SCR_DATA_OUT,
    input [7:0]B,
    input [7:0]IN_PORT,
    output [7:0]DIN
    );
    
    logic [7:0]T_DIN;
    
    always_comb
    begin
        case (RF_WR_SEL)
        2'b00:  T_DIN<=RESULT;
        2'b01:  T_DIN<=SCR_DATA_OUT;
        2'b10:  T_DIN<=B;
        2'b11:  T_DIN<=IN_PORT;
        endcase
    end
    
    assign DIN=T_DIN;
    
endmodule

module comb_ALU_Mux(
    input ALU_OPY_SEL,
    input [7:0]DY_OUT,
    input [7:0]IR,
    output [7:0]DIN
    );
    
    logic [7:0]T_DIN;
    
    always_comb
    begin
        case (ALU_OPY_SEL)
        1'b0:  T_DIN<=DY_OUT;
        1'b1:  T_DIN<=IR;
        endcase
    end
    
    assign DIN=T_DIN;
    
endmodule