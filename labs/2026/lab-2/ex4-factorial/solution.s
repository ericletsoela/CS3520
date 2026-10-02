.data
n:   .word 5
msg: .asciz "Factorial: "
.text
main:
    lw a0, n
    jal ra, factorial
    mv s0, a0
    la a0, msg
    li a7, 4
    ecall
    mv a0, s0
    li a7, 1
    ecall
    li a7, 10
    ecall

# factorial(a0=n) -> a0=n!; leaf procedure, 16-byte aligned frame
factorial:
    addi sp, sp, -16
    sw s1, 12(sp)
    sw s2, 8(sp)
    li s1, 1
    li s2, 2
factorial_loop:
    blt a0, s2, factorial_done
    mul s1, s1, s2
    addi s2, s2, 1
    jal x0, factorial_loop
factorial_done:
    mv a0, s1
    lw s2, 8(sp)
    lw s1, 12(sp)
    addi sp, sp, 16
    jalr x0, ra, 0
