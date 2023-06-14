#include "stdio.h"

unsigned int count_zero(int x)
{
    unsigned int res = 0;
    int help = x;
    for(int i = 0; i < 32; i++)
    {
        help = (x << i) >> 31;
        if(!help)
        {
            res++;
        }
    }
    return res;
}

int main(void)
{
    unsigned int x;
    scanf("%u", &x);
    printf("%d\n", count_zero(x));
    return 0;
}