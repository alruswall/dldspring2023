module stimulus ();

   logic  clk;
   logic  reset;
   logic  [5:0] outP;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   gol dut (reset, clk, outP);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("gol.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b %b || %b", 
		     reset, left, right);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1; // test left blink signal first by running reset, then off, then on, then quickly on + reset to make sure it isn't quitting in the middle of a cycle.
	#41  reset = 1'b0;	
	#0   left = 1'b0;
	#20  left = 1'b1;
	#20  left = 1'b0;
     #5   left = 1'b1;
     #10  left = 1'b0;
     #20  reset = 1'b0;

     //Same test bank as above, but for right.
     #0   reset = 1'b1; 
	#41  reset = 1'b0;	
	#0   right = 1'b0;
	#20  right = 1'b1;
	#20  right = 1'b0;
     #5   right = 1'b1;
     #10  right = 1'b0;
     #20  reset = 1'b0;

//Hazards test bank
     #0   reset = 1'b1; 
	#41  reset = 1'b0;	
	#0   right = 1'b0;
     #0   left  = 1'b0;
	#20  right = 1'b1;
     #0   left  = 1'b1;
	#20  right = 1'b0;
     #0   left  = 1'b0;
     #20  reset = 1'b0;
     #20  right = 1'b1;
     #0   left  = 1'b1;
     #0   reset = 1'b1;

     end

endmodule // gol_tb
