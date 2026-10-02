.data
first:  .word 48
second: .word 18
msg:    .asciz "GCD: "
.text
main:
    lw a0, first
    lw a1, second
    jal ra, gcd
    mv s0, a0
    la a0, msg
    li a7, 4
    ecall
    mv a0, s0
    li a7, 1
    ecall
    li a7, 10
    ecall

# gcd(a0=a, a1=b) -> a0=gcd(a,b); nonnegative inputs
# Leaf procedure: uses only caller-saved argument/temporary registers.
gcd:
    beq a1, x0, gcd_done
    rem t0, a0, a1
    mv a0, a1
    mv a1, t0
    beq x0, x0, gcd
gcd_done:
    jalr x0, ra, 0
