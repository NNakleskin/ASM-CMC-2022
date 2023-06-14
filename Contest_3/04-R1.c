#include "stdio.h"

unsigned int f(int n)
{
    unsigned int res = 1;
    for(int i = 0; i < n; i++)
    {
        res *= 3;
    }
    return res;
}

int main(void)
{
    int n;
    scanf("%d", &n);
    printf("%u\n", f(n));
    return 0;
}