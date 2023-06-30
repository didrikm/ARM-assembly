.section        .data

label:
                .zero 23
posoffset:
                .word 0,4,8,1,5,6,2,3,7
negoffset:
                .word 2,4,6,0,5,7,1,3,8
dettext:
                .ascii "Determinant: "
newline:
                .ascii "\n"

.section        .text
.align          2
.global         _start
_start:
                /*skriver ut "Determinant:"*/
                ldr r1, =dettext
                mov r2, #13
                mov r7, #4
                swi 0x0

                /*beräkning av determinant*/
                ldr r1, =_matrix
                ldr r2, =posoffset
                mov r8, #3
                mov r5, #1

posloop:        ldr r4, [r2]
                add r2, #4
                ldr r3, [r1, r4, lsl #2]
                mul r6, r5, r3
                mov r5, r6
                sub r8, #1
                cmp r8, #0
                bne posloop

                mov r9, r5

                ldr r2, =negoffset
                mov r8, #3
                mov r5, #1

negloop:        ldr r4, [r2]
                add r2, #4
                ldr r3, [r1, r4, lsl #2]
                mul r6, r5, r3
                mov r5, r6
                sub r8, #1
                cmp r8, #0
                bne negloop

                sub r3, r9, r5
                bl hexprint

                ldr r1, =newline
                mov r2, #1
                mov r7, #4
                swi 0x0
                mov r7, #1
                swi 0x0






