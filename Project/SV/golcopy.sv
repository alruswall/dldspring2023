module gol(start, clk, outGrid);
 input logic start;
 input logic clk;
 output logic [63:0] outGrid;
logic [63:0] grid;
logic [63:0] currentGrid;
logic [63:0] nextGrid;
 datapath prog(currentGrid, nextGrid);
 assign grid = 64'h4020_E000_0000_0000;



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
