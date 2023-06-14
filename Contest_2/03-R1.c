#include "stdio.h"

int main(void)
{
    int n, second = 1, first = 0;
    scanf("%d", &n);
    while(n != 0)
    {
        int c;
        c = second;
        second = first;
        first = c;
        
        second += first; 
        n--;
    }
    printf("%d\n", first);
    return 0;
}