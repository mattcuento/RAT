`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: 
// Date:
// Description: Controls the RAT CPU
//////////////////////////////////////////////////////////////////////////////////

module ControlUnit(
  input CLK,
  input C,
  input Z,
  input INT,
  input RESET,
  input [4:0]OPCODE_HI_5,
  input [1:0]OPCODE_LO_2,
  //fill in other outputs
  
  output logic I_SET,
  output logic I_CLR,
  
  output logic PC_LD,
  output logic PC_INC,
  output logic [1:0]PC_MUX_SEL,
  
  output logic ALU_OPY_SEL,
  output logic [3:0]ALU_SEL,
  
  output logic RF_WR,
  output logic [1:0]RF_WR_SEL,
  
  output logic SP_LD,
  output logic SP_INCR,
  output logic SP_DECR,
  
  output logic SCR_WE,
  output logic [1:0]SCR_ADDR_SEL,
  output logic SCR_DATA_SEL,
  
  output logic FLG_C_SET,
  output logic FLG_C_CLR,
  output logic FLG_C_LD,
  output logic FLG_Z_LD,
  output logic FLG_LD_SEL,
  output logic FLG_SHAD_LD,
  
  output logic RST,
  output logic IO_STRB
  );

  // Define States
  typedef enum {ST_FETCH, ST_EXEC, ST_INIT} STATES; 
  STATES NS, PS = ST_INIT;

  //concatenate opcode bits
  logic [6:0] s_opcode;
  assign s_opcode = {OPCODE_HI_5,OPCODE_LO_2};

  // Synchronous State Changes
  always_ff @ (posedge CLK)
    begin
      if (RESET == 1'b1)
        PS <= ST_INIT;
      else
        PS <= NS;
    end

  always_comb
    begin
      
      // Initialize all outputs to avoid latches
      // ...
      
I_SET<=1'b0;
        I_CLR<=1'b0;
        
        PC_LD<=1'b0;
        PC_INC<=1'b0;
        PC_MUX_SEL<=2'b00;
        
        ALU_OPY_SEL<=1'b0;
        ALU_SEL<=4'h0;
        
        RF_WR<=1'b0;
        RF_WR_SEL<=2'b00;
        
        SP_LD<=1'b0;
        SP_INCR<=1'b0;
        SP_DECR<=1'b0;
        
        SCR_WE<=1'b0;
        SCR_ADDR_SEL<=2'b00;
        SCR_DATA_SEL<=1'b0;
        
        FLG_C_SET<=1'b0;
        FLG_C_CLR<=1'b0;
        FLG_C_LD<=1'b0;
        FLG_Z_LD<=1'b0;
        FLG_LD_SEL<=1'b0;
        FLG_SHAD_LD<=1'b0;
        
        RST<=1'b0;
        IO_STRB<=1'b0;
      
      
      case (PS)
        ST_INIT: begin      // Initialize
          NS     <= ST_FETCH;
          RST	 <= 1'b1;
        end
        

        ST_FETCH: begin    // Fetch
            NS <= ST_EXEC;   
            PC_INC<=1'b1;   
        end

        ST_EXEC: begin      // Execute
     
          // Op Code Decoder
          case (s_opcode)

			//BRN
			7'b0010000:
			begin
			PC_LD<=1'b1;
			end
			
			//EXOR reg-reg
			7'b0000010:
            begin
            RF_WR<=1'b1;
            ALU_SEL<=4'b0111;
            FLG_C_CLR<=1'b1;
            FLG_Z_LD<=1'b1;
            end
			
			//EXOR reg-immed
            7'b1001000,7'b1001001,7'b1001010,7'b1001011:
            begin
		    RF_WR<=1'b1;
            ALU_SEL<=4'b0111;
            ALU_OPY_SEL<=1'b1;
            FLG_C_CLR<=1'b1;
            FLG_Z_LD<=1'b1;
			end

			//IN
			7'b1100100,7'b1100101,7'b1100110,7'b1100111:
			begin
			RF_WR<=1'b1;
			RF_WR_SEL<=2'b11;
			end
			
			//MOV reg-reg
			7'b0001001:
			begin
            RF_WR<=1'b1;
            ALU_SEL<=4'b1110;
			end
			
			//MOV reg-immed
            7'b1101100,7'b1101101,7'b1101110,7'b1101111:
            begin
            RF_WR<=1'b1;
            ALU_SEL<=4'b1110;
            ALU_OPY_SEL<=1'b1;
            end
            
            //OUT
            7'b1101000,7'b1101001,7'b1101010,7'b1101011:
            begin
            IO_STRB<=1'b1;
            end
            
            default:          // failsafe
              begin
              RST <= 1'b0;
              end

          endcase
          
          NS <= ST_FETCH;
          PC_INC <= 1'b0;
        end

        default:          // Failsafe
          NS <= ST_INIT;

      endcase
      
      
    end

endmodule