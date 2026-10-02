.data
first:  .word 48
second: .word 18
msg:    .asciz "GCD: "
.text
main:
    lw a0, first
    lw a1, second
    jal ra, gcd_recursive
    mv s0, a0
    la a0, msg
    li a7, 4
    ecall
    mv a0, s0
    li a7, 1
    ecall
    li a7, 10
    ecall

gcd_recursive:
    beq a1, x0, base_case
    addi sp, sp, -16
    sw ra, 12(sp)
    rem t0, a0, a1
    mv a0, a1
    mv a1, t0
    jal ra, gcd_recursive
    lw ra, 12(sp)
    addi sp, sp, 16
base_case:
    jalr x0, ra, 0
