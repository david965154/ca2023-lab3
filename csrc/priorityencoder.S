.org 0
# Provide program starting address to linker

.data
    data_0: .word 0b00000000000000000000000000000001
    data_1: .word 0b00000000000000000000000010000001
    data_2: .word 0b00000000000000001000000000000000
    data_3: .word 0b00000000100000000001010000000100
    data_4: .word 0b11111111111111111111111111111111
    nextline: .ascii "\n"
    .set str_size, .-nextline
    buffer: .byte 0
.text
.global main
    
main:
    mv t1, a0  
  
    addi sp, sp, -20
    
    # push four pointers of test data onto the stack
    lw t0, data_0
    sw t0, 0(sp)
    lw t0, data_1
    sw t0, 4(sp)
    lw t0, data_2
    sw t0, 8(sp)
    lw t0, data_3
    sw t0, 12(sp)
    lw t0, data_4
    sw t0, 16(sp)

    addi s0, x0, 5    # s0 is the iteration times(4 test case)
    addi s1, x0, 0    # s1 is counter
    addi s2, sp, 0    # s2 initial at (0)sp
    li a5, 2
    li a6, 0
loop:
    lw a1, 0(s2)        #load data into a0

    li a0, 16
    li t2, 16
    addi s2, s2, 4      # s2 move to next data
    addi s1, s1, 1      # counter++
    blt a1, a6, ulimitcase
    blt a1, a5, llimitcase
    jal clz

right:
    sub a0, a0, t2 
    jal clz
left:
    add a0, a0, t2
clz:
    srl a2, a1, a0
    srl t2, t2, 1
    beq a2, x0, right
    bge a2, a5, left
    jal det

llimitcase:
    li a0, 0
    jal print
ulimitcase:
    li a0, 31
    
print:
    slli t2, s1, 2
    sw a0, 0(t2)
    
    bne s1, s0, loop
    beq s1, s0, end
end:
    li a7, 93    # Exit system call
    ecall
