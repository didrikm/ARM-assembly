.section        .data
label:
                .zero 23

ProdText:
                .ascii "Product: [ "
EndVector:
                .ascii "]\n"

Space:
                .ascii " "

.section        .text
.align          2
.global         _start
_start:
                ldr r1, =ProdText
                mov r2, #11
                mov r7, #4
                swi 0x0
                ldr r1, =_matrix
                mov r6, #4
                mov r8, #48

storloop:
                ldr r2, =_vector
                mov r3, #4
                mov r5, #0

loop:
                mul r4, r1, r2
                add r5, r5, r4
                add r1, #1
                add r2, #1
                sub r3, r3, #1
                cmp r3, #0
                bne loop

                mov r3, r5
                bl hexprint

                ldr r1, =Space
                mov r2, #1
                swi 0x0

                sub r6, r6, #1
                cmp r6, #0
                bne storloop

                ldr r1, =EndVector
                mov r2, #2
                swi 0x0
                mov r7, #1
                swi 0x0

