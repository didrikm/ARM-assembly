.section        .data
indata:         .zero 23
med:            .asciz "Vad heter du?\n"
med2:           .asciz "Hej "
med3:           .asciz ", trevligt att träffa dig!\n"
.section        .text
.align          2
.global         _start
_start:
                ldr r1, =med
                mov r2, #14
                bl print

                ldr r1, =indata
                mov r2, #23
                bl read

                sub r8, r0, #1

                ldr r1, =med2
                mov r2, #4
                bl print

                /*sub r8, r0, #1*/
                ldr r1, =indata
                mov r2, r8
                bl print

                ldr r1, =med3
                mov r2, #28
                bl print

                mov r7, #1
                swi 0x0

