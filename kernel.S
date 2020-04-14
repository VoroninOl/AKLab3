.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
#define A #30
#define B #20
#define C #2
//global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    start: .asciz "Kernel started!\n"
    final: .asciz "Answer = : "

.section .text
__kernel_reset__:
    ldr r0, =start
    bl dbgput_line
    
    // calculate 
    mov r1, A
    mov r2, B
    mov r3, C
    bl calc
    pop {pc}
calc:
    sub r4, r1, r2
    cmp r4, #0
    it ge
    addge r4, r2, r1
    sdiv r4, r3

    ldr r0, =final
    bl dbgput
    mov r0, r4
    bl dbgput_num
    end:
    b end


