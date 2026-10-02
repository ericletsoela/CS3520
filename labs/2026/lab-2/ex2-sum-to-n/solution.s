.data
n:   .word 10
msg: .asciz "Sum: "
.text
main:
    lw t0, n
    li t1, 1
    li t2, 0
loop:
    blt t0, t1, done
    add t2, t2, t1
    addi t1, t1, 1
    beq x0, x0, loop
done:
    la a0, msg
    li a7, 4
    ecall
    mv a0, t2
    li a7, 1
    ecall
    li a7, 10
    ecall
