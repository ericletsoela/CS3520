# Exercise 2 - sum to N
With `N=10`, the C++ model prints `Sum: 55`. `t0` holds N, `t1` the counter beginning at 1, and `t2` the running sum. The exit branch is `N < i`, the negation of `i <= N`. For N=0 or a negative N the loop runs zero times and prints 0. Keep N small enough that the signed 32-bit sum does not overflow (N at most 65535).
