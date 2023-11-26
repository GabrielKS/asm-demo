#include <stdio.h>
int main() {
    // Declaring as volatile keeps this from being optimized away
    volatile int x = 42;
    x += 5;
    printf("%d\n", x);
    return 0;
}
