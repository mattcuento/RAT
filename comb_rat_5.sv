`timescale 1ns / 1ps

module comb_rat_5;
    logic CLK;
    logic C;
    logic Z;
    logic INT;
    logic RESET;
    logic [7:0]IN_PORT;
    logic [4:0]OPCODE_HI_5;
    logic [1:0]OPCODE_LO_2;
    //fill in other output
    
    //interrupt
    logic I_SET;
    logic I_CLR;
    
    //Program Counter
        //PC inputs
            logic PC_LD;
            logic PC_INC;
            logic [1:0]PC_MUX_SEL;
            logic [9:0]PC_DIN;
        //PC output
            logic [9:0]PC_COUNT;
    //ALU
        //ALU inputs
            logic ALU_OPY_SEL;
            logic [3:0]ALU_SEL;
            //IR[7:0]
            //DY_OUT[7:0]
            //C_FLAG
        //ALU outputs
            logic ALU_C;
            logic ALU_Z;
            logic [7:0]RESULT;
    //Register File
        //RF inputs
            logic RF_WR;
            logic [1:0]RF_WR_SEL;
            //IR[12:8]
            //IR[7:3]
        //RF outputs
            logic [7:0]DX_OUT;
            logic [7:0]DY_OUT;
    //Stack Pointer
        //SP inputs
            logic SP_LD;
            logic SP_INCR;
            logic SP_DECR;
            //RST
        //SP outputs
            //DATA_OUT
    //Scratch Ram
        //SCR inputs
            logic SCR_WE;
            logic [1:0]SCR_ADDR_SEL;
            logic SCR_DATA_SEL;
        //SCR outputs
    
    
    
    
    logic FLG_C_SET;
    logic FLG_C_CLR;
    logic FLG_C_LD;
    logic FLG_Z_LD;
    logic FLG_LD_SEL;
    logic FLG_SHAD_LD;
    
    logic RST;
    logic IO_STRB;
    logic [7:0]OUT_PORT;
    //wires

    
    logic [7:0]RF_DIN;
    logic [7:0]ALU_DIN;
    
    logic [9:0]STACK;
    logic [7:0]B;
    
    logic [17:0]IR;
    
    assign OPCODE_HI_5=IR[17:13];
    assign OPCODE_LO_2=IR[1:0];
    assign OUT_PORT=IO_STRB ? DX_OUT : 8'h00;
    
    //clk
    clk clk0(.*);
    //PC
    ProgramCounter pc0(
        .PC_LD(PC_LD),
        .PC_INC(PC_INC),
        .PC_DIN(PC_DIN),
        .RST(RST),
        .CLK(CLK),
        .PC_COUNT(PC_COUNT)
        );
        //PC MUX
        comb_PC_Mux pc1(
            .FROM_IMMED(IR[12:3]),
            .FROM_STACK(STACK),
            .PC_MUX_SEL(PC_MUX_SEL),
            .MUX_O(PC_DIN)
            ); 
    //ProgRom
    ProgRom pr0(
        .PROG_CLK(CLK),
        .PROG_ADDR(PC_COUNT),
        .PROG_IR(IR)
        );    
    //REG FILE
    REG_FILE rf0(
        .DIN(RF_DIN),
        .ADRX(IR[12:8]),
        .ADRY(IR[7:3]),
        .RF_WR(RF_WR),
        .CLK(CLK),
        .DX_OUT(DX_OUT),
        .DY_OUT(DY_OUT)
        );
        //RF WR
        comb_RF_Mux rf1(
            .RF_WR_SEL(RF_WR_SEL),
            .RESULT(RESULT),
            .SCR_DATA_OUT(STACK[7:0]),
            .B(B),
            .IN_PORT(IN_PORT),
            .DIN(RF_DIN)
            );   
    //logic [7:0]buff_ALU_DIN;
    //assign ALU_DIN=PC_INC ? buff_ALU_DIN : 8'h00;
    
    //ALU
    ALU alu0(
        .SEL(ALU_SEL),
        .A(DX_OUT),
        .B(ALU_DIN),
        .CIN(C),
        .RESULT(RESULT),
        .C(ALU_C),
        .Z(ALU_Z)
        );
        //ALU OPY
        comb_ALU_Mux alu1(
            .ALU_OPY_SEL(ALU_OPY_SEL),
            .DY_OUT(DY_OUT),
            .IR(IR[7:0]),
            .DIN(ALU_DIN)
            );
    //Flags
    Flags fl0(
        .FLG_CLK(CLK),
        .FLG_C_SET(FLG_C_SET),
        .FLG_C_CLR(FLG_C_CLR),
        .FLG_C_LD(FLG_C_LD),
        .FLG_Z_LD(FLG_Z_LD),
        .FLG_LD_SEL(FLG_LD_SEL),
        .FLG_SHAD_LD(FLG_SHAD_LD),
        .FLG_CIN(ALU_C),
        .FLG_ZIN(ALU_Z),
        .FLG_COUT(C),
        .FLG_ZOUT(Z)
        );
    //Control Unit
    ControlUnit cu0(
        .CLK(CLK),
        .C(C),
        .Z(Z),
        .INT(INT),
        .RESET(RESET),
        .OPCODE_HI_5(OPCODE_HI_5),
        .OPCODE_LO_2(OPCODE_LO_2),
        //fill in other outputs
        
        .I_SET(I_SET),
        .I_CLR(I_CLR),
        
        .PC_LD(PC_LD),
        .PC_INC(PC_INC),
        .PC_MUX_SEL(PC_MUX_SEL),
        
        .ALU_OPY_SEL(ALU_OPY_SEL),
        .ALU_SEL(ALU_SEL),
        
        .RF_WR(RF_WR),
        .RF_WR_SEL(RF_WR_SEL),
        
        .SP_LD(SP_LD),
        .SP_INCR(SP_INCR),
        .SP_DECR(SP_DECR),
        
        .SCR_WE(SCR_WE),
        .SCR_ADDR_SEL(SCR_ADDR_SEL),
        .SCR_DATA_SEL(SCR_DATA_SEL),
        
        .FLG_C_SET(FLG_C_SET),
        .FLG_C_CLR(FLG_C_CLR),
        .FLG_C_LD(FLG_C_LD),
        .FLG_Z_LD(FLG_Z_LD),
        .FLG_LD_SEL(FLG_LD_SEL),
        .FLG_SHAD_LD(FLG_SHAD_LD),
        
        .RST(RST),
        .IO_STRB(IO_STRB)
    
    );

    initial
    begin
    IN_PORT=8'h01;
    INT=1'b0;
    RESET=1'b1;
    #10;
    IN_PORT=8'h01;
    INT=1'b0;     
    RESET=1'b0;   
    #10;          
    IN_PORT=8'h10;
    INT=1'b0;      
    RESET=1'b0;   
    #10;          
    end
    
endmodule