

// Trabalho 2 Rodrigo Almeida Costa


module Pisca(
	input CLOCK_50,
	output LEDG
	);

	reg estado =0;
	reg [32:0]cont = 0;

   	assign LEDG = estado;

	always @(posedge CLOCK_50) begin
		if (cont == 5) begin		
	      	estado = ~estado;
       	    cont = 0;
	   	end 
	   	else begin
        	cont = cont + 1;
	   	end
	end
endmodule

module test;
    reg CLOCK_50;
	wire LEDG;

    	Pisca A(CLOCK_50,LEDG);

    	always #1 CLOCK_50 <= ~CLOCK_50;

    	initial begin
        $dumpvars(0 , A);
		#0;	
        CLOCK_50 <= 0;
		#500;
        $finish;
    	end
endmodule
