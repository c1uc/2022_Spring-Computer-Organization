.data
arr: .word 5, 3, 6, 7, 31

size: .word 5

str1: .string "Array： \n"
str2: .string "Sorted： \n"

space: .string " "

nr: .string "\n"

.text
main:
    la a1, arr
    la a2 size
    
    la a0, str1
    li a7, 4
    ecall
    
    jal ra, printArray
    
    li t0, 0
    jal ra, bubbleSort
    
    la a0, str2
    li a7, 4
    ecall
    
    jal ra, printArray
    
    li a7, 10
    ecall
    
#t0: i, t1: j, a1: arr, a2: size
bubbleSort:
    la a1, arr
    lw a2, size
    j loop1
    
    
loop1:
    la a1, arr
    addi, t1, t0, -1
    blt t0, a2, loop2
    ret
        
        
loop2:
    blt t1, zero, loop2e # j < 0
    
    la a1, arr
    slli t4, t1, 2
    add a1, a1, t4
    
    lw t2, 0(a1)
    lw t3, 4(a1)
    ble t2, t3, loop2e # data[j] <= data[j+1]
    
    j swap
    
    
swap:
    lw t4, 0(a1)
    sw t3, 0(a1)
    sw t4, 4(a1)
    
    addi t1, t1, -1
    addi a1, a1, -4
    j loop2
    
loop2e:
    addi t0, t0, 1
    j loop1
    

#a0: to print
#a7: 4:string, 1:int
printArray:
    la t0, arr
    lw t1, size
    slli t1, t1, 2
    
    add t1, t0, t1
    
    loop_array:
        lw a0, 0(t0)
        li a7, 1
        ecall
        
        la a0, space
        li a7, 4
        ecall
        
        addi t0, t0, 4
        blt t0, t1, loop_array
        
    la a0, nr
    li a7, 4
    ecall
    
    ret
