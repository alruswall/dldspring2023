module gol(start, clk, outGrid);
 input logic start;
 input logic clk;
 output logic [63:0] outGrid;
logic [63:0] grid;
logic [63:0] currentGrid;
logic [63:0] nextGrid;
 datapath prog(currentGrid, nextGrid);
 assign grid = 64'h4020_E000_0000_0000;

flopr(clk, start, nextGrid, grid, outGrid);

   typedef enum 	logic [3:0] {S0, cal, st} statetype;
   statetype state, nextstate;
   always_ff @(posedge clk, posedge start)
     if (start) state <= S0;
     else       state <= nextstate;

    assign currentGrid = (start) ? grid: outGrid;
endmodule

module flopr(input  logic       clk,
             input  logic       reset, 
             input  logic [63:0] d, 
             input  logic [63:0] seed,
             output logic [63:0] q);

  // asynchronous reset (similar to HDL Example 4.19)
  always_ff @(posedge clk, posedge reset)
     if (reset) q <= seed;
     else       q <= d;
   
endmodule