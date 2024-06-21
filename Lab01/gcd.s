.data
num1: .word 4
num2: .word 8

str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
    lw a1, num1
    lw a2, num2
    
    jal ra, gcd
    
    la a0, str1
    li a7, 4
    ecall
    
    lw a0, num1
    li a7, 1
    ecall
    
    la a0, str2
    li a7, 4
    ecall
    
    lw a0, num2
    li a7, 1
    ecall
    
    la a0, str3
    li a7, 4
    ecall
    
    mv a0, s0
    li a7, 1
    ecall
    
    li a7, 10
    ecall
    
    
gcd:
    beq a2, zero, if0
    
    rem a3, a1, a2
    
    addi sp, sp, -4
    sw ra, 0(sp)
    
    mv a1, a2
    mv a2, a3
    
    jal ra, gcd
    
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
    
    
if0:
    mv s0, a1
    ret