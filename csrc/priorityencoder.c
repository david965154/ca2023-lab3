#include <stdio.h>
#include <stdint.h>

uint16_t count_leading_zeros(uint64_t x)
{
    int pace = 16;
    int adj = 16;
    int y;
    while(x>1){
        y = x >> pace;
        adj>>=1;
        if(y>1){
            pace+=adj;
        }
        else if(y<1){
            pace-=adj;
        }
        else if(y==1){
            return (64-pace);
        }
    }
    return 64;
}

int main() {
    *((volatile int *) (4)) = 64 - count_leading_zeros(1);
    *((volatile int *) (8)) = 64 - count_leading_zeros(129);
    *((volatile int *) (12)) = 64 - count_leading_zeros(32768);
    *((volatile int *) (16)) = 64 - count_leading_zeros(8393732);
    *((volatile int *) (20)) = 64 - count_leading_zeros(4294967295);
    return 0;
}
