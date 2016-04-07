#include <stdio.h>
#include <stdlib.h>
#include <time.h>




int main(){
	int i, j,x,y;

	FILE *ArquivoTriangulos;

	ArquivoTriangulos = fopen("ArquivoTriangulos.txt","w");

    srand(time(NULL));

    for (i = 0;i < 10; i++)
        fprintf(ArquivoTriangulos,"%d %d %d %d %d %d\n",rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100);

    fclose(ArquivoTriangulos);



	return 0;
}

