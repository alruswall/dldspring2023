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
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b %b", 
		     start, clk);
     end   
   
   initial 

     begin      
	#0   start = 1'b1;
	#41  start = 1'b0;
     
     end

endmodule // gol_tb
