#include <stdio.h>
#include <stdlib.h>

struct fPoint{
	int x;
	int y;
};


float sign (struct fPoint pt, struct fPoint p1, struct fPoint p2)
{
    return ((pt.x - p2.x) * (p1.y - p2.y)) - ((p1.x - p2.x) * (pt.y - p2.y));
}

int PointInTriangle (struct fPoint pt, struct fPoint v1, struct fPoint v2, struct fPoint v3)
{
    float b1, b2, b3;
	int InTriangle = 0;

    b1 = sign(pt, v1, v2);
    b2 = sign(pt, v2, v3);
    b3 = sign(pt, v3, v1);

	if(b1 <= 0)
		b1 = 1;

	if(b2 <= 0)
		b2 = 1;

	if(b3 <= 0)
		b3 = 1;


	if (b1 == b2 && b2 == b3){
		InTriangle = 1;
	}

    return InTriangle;
}




int main(){
	struct fPoint p1,p2,p3,pt;
	int InTriangle;
	int i, j,x,y;
	int cont = 0;

	FILE *ArquivoTriangulos;
	FILE *ArquivoGerado;


	ArquivoGerado = fopen("ArquivoGerado.txt","w");

	cont = 1;

    for (i = 99; i >= 0; i--){
        for(j = 0; j<100;j++){
            pt.y = i; pt.x = j;
            InTriangle = 0;
            ArquivoTriangulos = fopen("ArquivoTriangulos.txt","r");

            while ((fscanf(ArquivoTriangulos,"%d %d %d %d %d %d", &p1.x,&p1.y,&p2.x,&p2.y,&p3.x,&p3.y))!= EOF ){
                if (InTriangle == 0){
                    InTriangle = PointInTriangle(pt,p1,p2,p3);
                }
            }
            fclose(ArquivoTriangulos);

            cont++;
            fprintf(ArquivoGerado,"%04x %d\n",cont,InTriangle);

            /*if(InTriangle == 1){
                printf("*");
            }else{
                printf(" ");
            }*/
        }
        printf("\n");
    }

    fclose(ArquivoGerado);

	//InTriangle = PointInTriangle (pt,p1,p2,p3);
	//printf("\n%d\n\n",InTriangle);
	return 0;
}

