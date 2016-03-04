# Sistemas-Digitais
Conteúdo referente a disciplina de Sistemas Digitais
module Pisca(input op,
             output led);

    assign led = op;


endmodule

module test;
    reg op;
    wire led;

    Pisca A(op,led);

    always #2 op <= ~op;

    initial begin
        $dumpvars(0 , A);
        op <= 0;
        #50;
        $finish;
    end

endmodule
