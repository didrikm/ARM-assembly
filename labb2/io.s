.section        .data

hej:
                .zero 23
hej2:
                .asciz "Hej"

.section        .text
.align          2
.global         read
.global         print


read:
                mov r0, #1 /* vet ej vad denna gör */
                mov r7, #3 /* system call 3, read */
                swi 0x0
                bx lr


print:
                mov r0, #1
                mov r7, #4 /* system call 4, write */
                swi 0x0
                bx lr



