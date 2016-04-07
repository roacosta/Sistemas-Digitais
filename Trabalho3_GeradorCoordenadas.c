#include <stdio.h>
#include <stdlib.h>
#include <time.h>




int main(){
	int i, j,x,y;

	FILE *ArquivoCoordenadas;

	ArquivoCoordenadas = fopen("ArquivoCoordenadas.txt","w");


    srand(time(NULL));

    for (i = 0;i < 10; i++)
        fprintf(ArquivoCoordenadas,"%d %d %d %d %d %d %d %d\n",rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100,rand() % 100);

    fclose(ArquivoCoordenadas);

	ArquivoCoordenadas = fopen("ArquivoCoordenadas.txt","r");

	return 0;
}

