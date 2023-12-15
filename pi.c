#include <stdio.h>
int main() {
    // Use a temporary variable to avoid "unsequenced modification and access" warnings
    long x = 0;
    for (long t=0,n=0,y=1;;) {
        x = (int)((t++*y+n++)>>7);
        n -= (y*y+x*x)>>62;
        y = x;
        // Print every 2^(64-36)=268,435,456 iterations
        if (t<<36 == 0) printf("%.17g\n",n*4./t);
    }
    return 0;  // Unreachable
}
