
// Trabalho 2 Rodrigo Almeida Costa


module Pisca(
	input CLOCK_50,
	output [1:0] LEDG
	);

	reg estado =0;
	reg [32:0]cont = 0;

   	assign LEDG[0] = estado;

	always @(posedge CLOCK_50) begin
		if (cont == 50000000) begin		
	      		estado = ~estado;
       	    		cont = 0;
	   	end 
	   	else begin
        		cont <= cont + 1;
	   	end
	end
endmodule
