.data
num: .word 7

str1: .string "th number in the Fibonacci sequence is "

.text
main:    
    lw a1, num
    li s1, 1
    jal ra, fib
    
    lw a0, num
    li a7, 1
    ecall
    
    la a0, str1
    li a7, 4
    ecall
    
    mv a0, t0
    li a7, 1
    ecall
    
    li a7, 10
    ecall
    
fib:
    beq a1, zero, if0
    beq a1, s1, if1
    
    addi sp, sp, -12
    sw ra, 8(sp)
    sw a1, 4(sp)
    
    addi a1, a1, -1
    jal ra, fib
    sw t0, 0(sp)
    
    lw a1, 4(sp)
    addi a1, a1, -2
    jal ra, fib
    
    lw t1, 0(sp)
    add t0, t0, t1
    lw ra, 8(sp)
    addi sp, sp, 12
    
    ret
    
if0:
    li t0, 0
    ret
    
if1:
    li t0, 1
    ret