.data
values: .word 7, 12, -4, 9, 0, 15, 28
n:      .word 7
msg:    .asciz "Even count: "
.text
main:
    la t0, values
    lw t1, n
    li t2, 0
    li t3, 0
loop:
    bge t2, t1, done
    slli t4, t2, 2
    add t4, t0, t4
    lw t5, 0(t4)
    andi t6, t5, 1
    bne t6, x0, next
    addi t3, t3, 1
next:
    addi t2, t2, 1
    beq x0, x0, loop
done:
    la a0, msg
    li a7, 4
    ecall
    mv a0, t3
    li a7, 1
    ecall
    li a7, 10
    ecall
