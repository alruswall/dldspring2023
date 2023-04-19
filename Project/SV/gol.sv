module gol(start, clk, toHDMI);
 input logic start;
 input logic clk;
 output logic [63:0] toHDMI;
logic [63:0] grid;
logic [63:0] currentGrid;
logic [63:0] nextGrid, outGrid;
 datapath prog(currentGrid, nextGrid);
 assign grid = 64'h4020_E000_0000_0000;

    register regname(outGrid, start, clk, toHDMI);

   typedef enum 	logic [3:0] {S0, cal, st} statetype;
   statetype state, nextstate;
   always_ff @(posedge clk, posedge start)
     if (start) state <= S0;
     else       state <= nextstate;

   always_comb
     case (state)
//initial state
      S0: begin
      outGrid = grid;
      nextstate = cal;
      end
//put into datapath
      cal: begin
        currentGrid = outGrid;
        nextstate = st;
      end
      st: begin
//set to grid
        outGrid = nextGrid;
        nextstate = cal;
      end
     endcase
endmodule

module register (input logic [63:0] d,  
              input logic rstn,  
              input logic clk,  
              output logic [63:0] q);  
  
    always @ (posedge clk or negedge rstn)  
       if (!rstn)  
          q <= 64'b0;  
       else  
          q <= d;  
endmodule  