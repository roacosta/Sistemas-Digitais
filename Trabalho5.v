module sinal (

    input [11:0] Ponto1X,
    input [11:0] Ponto1Y,

    input [11:0] Ponto2X,
    input [11:0] Ponto2Y,

    input [11:0] PontoTX,
    input [11:0] PontoTY,

    output sinal

    );

    // Declaração dos Fios
    wire signed [11:0] Subtracao1;
    wire signed [11:0] Subtracao2;
    wire signed [11:0] Subtracao3;
    wire signed [11:0] Subtracao4;

    wire signed [22:0] Multiplicacao1;
    wire signed [22:0] Multiplicacao2;

    wire signed [22:0] Subtracao5;


    // Ligação dos Fios

    assign Subtracao1 = PontoTX - Ponto2X;
    assign Subtracao2 = Ponto1Y - Ponto2Y;
    assign Subtracao3 = Ponto1X - Ponto2X;
    assign Subtracao4 = PontoTY - Ponto2Y;

    assign Multiplicacao1 = Subtracao1 * Subtracao2;
    assign Multiplicacao2 = Subtracao3 * Subtracao4;

    assign Subtracao5 = Multiplicacao1 - Multiplicacao2;

    assign sinal = (Subtracao5 >= 0) ? 1 : 0; //==== Verifica se o resultado da ultima multiplicação é maior ou igual a zero e retornar o sinal 1 ou 0.

endmodule


module PercorreLinhas(
    input Clock
    );

    reg [11:0] linha = 50;
    wire MudaLinha;

    always @(posedge MudaLinha) begin
        if (linha > 0) begin
            linha <= linha - 1;
            //$write("\n");
        end
    end

    PercorreColunas coluna(Clock,linha, MudaLinha);

endmodule

module PercorreColunas(
    input Clock,
    input [11:0] linha,
    output MudaLinha
    );

    reg [11:0] Coluna = 0;

    wire MudaColuna;

    assign MudaLinha = (Coluna == 40) ? 0:1; //(Coluna = 0) ? 1:0;

    always @(posedge MudaColuna) begin
        if (Coluna == 40) begin
            Coluna = 0;
        end else begin
            Coluna = Coluna + 1;
            //
        end
        //$display("%d %d", linha, Coluna);
    end

    Arquivos T(Clock,linha,Coluna,MudaColuna);
endmodule

module Arquivos(
    input Clock,
    input [11:0] linha,
    input [11:0] coluna,
    output MudaColuna
    );

    reg [11:0] Ponto1X;
    reg [11:0] Ponto1Y;

    reg [11:0] Ponto2X;
    reg [11:0] Ponto2Y;

    reg [11:0] Ponto3X;
    reg [11:0] Ponto3Y;

    reg [3:0] Estado = 0;

    reg enable = 1;


    integer RetornoEntradas, RetornoSaidas, Valor;

    assign MudaColuna = (Estado == 3) ? 1:0;

    always @(posedge Clock) begin
        case (Estado)
            0: begin
                RetornoEntradas = $fopen("ArquivoTriangulos.txt","r");

                while (!$feof(RetornoEntradas)) begin
                    Valor = $fscanf(RetornoEntradas, "%d %d %d %d %d %d",Ponto1X,Ponto1Y,Ponto2X,Ponto2Y,Ponto3X,Ponto3Y);
                end
                Ponto1X = 10;
                Ponto1Y = 10;
                Ponto2X = 10;
                Ponto2Y = 30;
                Ponto3X = 30;
                Ponto3Y = 20;


                Estado <= 1;
            end

            1: begin
                RetornoSaidas = $fopen("ArquivoSaidaVerilog.txt","a+");
                $fdisplay(RetornoSaidas,". %d %d %d %d %d %d %d %d %d %d",Ponto1X,Ponto1Y,Ponto2X,Ponto2Y,Ponto3X,Ponto3Y,linha,coluna,Saida);
                //if (Saida == 1) begin
                //    $write("*");
                //end else begin
                //    $write(" ");
                //end

                Estado <= 2;

                end
            2: begin
                Estado <= 3;
                end
            3: begin
                Estado <= 0;

                end
        endcase
    end

    TesteTriangulo TesteTri(enable,Ponto1X,Ponto1Y,Ponto2X,Ponto2Y,Ponto3X,Ponto3Y,coluna,linha,Saida);
endmodule

module TesteTriangulo (
    input enable,
    input [11:0] Ponto1X,
    input [11:0] Ponto1Y,

    input [11:0] Ponto2X,
    input [11:0] Ponto2Y,

    input [11:0] Ponto3X,
    input [11:0] Ponto3Y,

    input [11:0] PontoTX,
    input [11:0] PontoTY,



    output dentro
    );

    wire sinal1;
    wire sinal2;
    wire sinal3;

    assign dentro = (sinal1 == sinal2 && sinal2 == sinal3 && enable == 1) ? 1:0;

    sinal S1(Ponto1X, Ponto1Y, Ponto2X, Ponto2Y, PontoTX, PontoTY, sinal1);
    sinal S2(Ponto2X, Ponto2Y, Ponto3X, Ponto3Y, PontoTX, PontoTY, sinal2);
    sinal S3(Ponto3X, Ponto3Y, Ponto1X, Ponto1Y, PontoTX, PontoTY, sinal3);

endmodule

module Teste;
    wire Dentro;

    reg Clock;

    always #1 Clock <= ~Clock;

    PercorreLinhas linha(Clock);

    initial
        begin
           $dumpvars(0,linha);
           #1
           Clock <= 0;
           #16070
           $finish;
        end
endmodule
