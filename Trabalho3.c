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
	int cont = 0;2;

	FILE *ArquivoCoordenadas;
	FILE *ArquivoGerado;

	ArquivoCoordenadas = fopen("ArquivoCoordenadas.txt","r");
	ArquivoGerado = fopen("ArquivoGerado.txt","w");

	cont = 1;

	while ((fscanf(ArquivoCoordenadas,"%d %d %d %d %d %d %d %d", &p1.x ,&p1.y,&p2.x,&p2.y,&p3.x,&p3.y,&pt.y,&pt.x))!= EOF ){


        //fscanf(ArquivoCoordenadas,"%d %d %d %d %d %d %d %d", &p1.x ,&p1.y,&p2.x,&p2.y,&p3.x,&p3.y,&pt.y,&pt.x);
        InTriangle = PointInTriangle(pt,p1,p2,p3);
        fprintf(ArquivoGerado,"%d %d %d %d %d %d %d %d %d \n", p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,pt.x,pt.y,InTriangle);
        //fprintf(ArquivoGerado,"%d %d %d %d %d %d %d %d\n", p1.x ,p1.y,p2.x,p2.y,p3.x,p3.y,pt.y,pt.x
	}

	//InTriangle = PointInTriangle (pt,p1,p2,p3);
	//printf("\n%d\n\n",InTriangle);
	return 0;
}

