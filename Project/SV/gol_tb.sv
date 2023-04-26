module stimulus ();

   logic  start;
   logic  clk;

   logic  [63:0] outGrid;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   gol dut (start, clk, outGrid);      
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives outGrid out file name
	handle3 = $fopen("gol.out");
     desc3 = handle3;
	// Tells when to finish simulation
	#500 $finish;		
     end

   always@(outGrid)
     begin
	
	$fdisplay(desc3, "%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", 
		     outGrid[63:56],outGrid[55:48],outGrid[47:40],outGrid[39:32],outGrid[31:24],outGrid[23:16],outGrid[15:8],outGrid[7:0]);
     end   
   
   initial 

     begin      
	#0   start = 1'b1;
	#41  start = 1'b0;
     
     end

endmodule // gol_tb
