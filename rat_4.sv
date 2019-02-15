`timescale 1ns / 1ps

module ALU(
    input [3:0]SEL,
    input [7:0]A,
    input [7:0]B,
    input CIN,
    output reg [7:0]RESULT,
    output reg C,
    output reg Z
    );
    logic [8:0]X;
    
    always_comb
    begin
        case (SEL)
        4'b0000:        //ADD
            X=A+B;
        4'b0001:        //ADDC
            X=A+B+CIN;
        4'b0010:        //SUB
            X=A-B;
        4'b0011:        //SUBC
            X=A-B-CIN;
        4'b0100:        //CMP
            X=A-B;
        4'b0101:        //AND
            X=A&B;
        4'b0110:        //OR
            X=A|B;
        4'b0111:        //EXOR
            X=A^B;
        4'b1000:        //TEST
            X=A&B;
        4'b1001:        //LSL
            X={A[7:0],CIN};
        4'b1010:        //LSR
            X={A[0],CIN,A[7:1]};
        4'b1011:        //ROL
            X={A[7],A[6:0],A[7]};
        4'b1100:        //ROR
            X={A[0],A[0],A[7:1]};
        4'b1101:        //ASR
            X={A[0],A[7],A[7:1]};
        4'b1110:        //MOV
            X={CIN,A[7:0]};
        4'b1111:        //unused
            begin 
            X=8'b0;
            $display("Unused, result is 0");
            end 
        endcase
        
            RESULT=X[7:0];
            C=X[8];
            Z=(X==8'b0); 
    end
endmodule