.data
first:  .word 17
second: .word 29
msg:    .asciz "Larger: "
.text
main:
    lw t0, first
    lw t1, second
    bge t0, t1, selected
    mv t0, t1
selected:
    mv t2, t0
    la a0, msg
    li a7, 4
    ecall
    mv a0, t2
    li a7, 1
    ecall
    li a7, 10
    ecall
