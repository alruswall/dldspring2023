module gol(start, clk, outGrid)
 input start;
 output [63:0] outGrid;
 assign grid = 64'h4020_E000_0000_0000;
 datapath prog(currentGrid, nextGrid);

   typedef enum 	logic [3:0] {S0, cal, st} statetype;
   always_ff @(posedge clk, posedge reset)
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