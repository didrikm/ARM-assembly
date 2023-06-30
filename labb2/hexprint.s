.section        .data
tabell:
                .asciz "0123456789abcdef"
label:
                .zero 23
.section        .text
.align          2
.global         hexprint
hexprint:
                mov r12, r6
                mov r6, #0xf0
                mov r9, #4
                b loop
loop2:          mov r9, #0
                mov r6, #0xf
loop:           ldr r4, =tabell
                and r8, r3, r6
                lsr r8, r9
                add r4, r4, r8
                mov r1, r4
                mov r2, #1
                mov r0, #1
                mov r7, #4
                swi 0x0
                cmp r6, #0xf0
                beq loop2
                mov r6, r12
                bx lr
~                                                                                        
~                                                                                        
~                                                                                        
~                                                                                        
~                                                                                        
~                                                                                        
~                                                                                        
~                                                
