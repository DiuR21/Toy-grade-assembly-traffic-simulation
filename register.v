`timescale 1ns/1ns
module register(
                input clk,
                input ena,
                input rst,
                input [7:0] data,
                output reg[15:0] opc_iraddr);
  reg state;
  
  always@ (posedge clk)
    begin
      if(rst)
        begin
          opc_iraddr <= 16'b0000_0000_0000_0000;
          state <= 1'b0;
        end
      else
        if(ena)
          begin
            casex(state)
              1'b0:
                begin
                  opc_iraddr[15:8] <= data;
                  state <= 1;
                end
              1'b1:
                begin
                  opc_iraddr[7:0] <= data;
                  state <= 0;
                end
              default:
                begin
                  opc_iraddr[15:0] <= 16'bxxxx_xxxx_xxxx_xxxx;
                  state <= 1'bx;
                end
            endcase
          end
      else
        state <= 1'b0;
    end
endmodule