.section        .data
matrisA:        .word 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

hej:            .word 23
tabell:
                .asciz "0123456789abcdef"
value:          .word 0

p:              .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0

startbracket:   .asciz "["
stopbracket:    .asciz "]"
newline:        .asciz "\n"

.section        .text
.global         _start
_start:

#-----------------------------------------
#Skriver matrisen på r�tt form

                mov r5, #4 /*vektorlängden N*/
                ldr r2, =_matrix
                ldr r3, =_vector
                ldr r4, =matrisA


storloop:       mov r1, #4 /*Matrisstorleken N*/

aloop:          ldr r9, [r2]
                str r9, [r4]
                add r4, r4, #4
                sub r1, r1, #1
                add r2, r2, #4
                cmp r1, #0
                bne aloop
                ldr r8, [r3]
                str r8, [r4]
                add r4, r4, #4
                add r3, r3, #4
                sub r5, r5, #1
                cmp r5, #0
                bne storloop
                b upp
#-------------------------------------------
#r3 t�ljare, r2 n�mnare
div:            cmp r2, #0 /*Avbryter ifall n�mnaren �r noll f�r att f�rhindra evighetsloop*/
                beq tillbaka

                mov r1, #0
                b Lloopkoll
Lloop:          add r1, r1, #1
                sub r3, r3, r2
Lloopkoll:      cmp r3, r2
                bhs Lloop
                bx lr
                #Svaret ligger nu i r1

tillbaka:       bx lr

#-------------------------------------------
upp:
                ldr r0, =matrisA
                mov r2, #4 /* N */
                mov r3, #0 /*radr�knare: ska g� �till -> N-1 pga nollindexering */
                mov r4, #0 /*kolumnr�knare, ska gå till N pga av extrarad som �r vektor**/


loop:           add r1, r2, #1
                mul r5, r1, r3
                add r5, r5, r4
                lsl r8, r5, #2
                add r9, r0, r8
                ldr r6, [r9]
                lsl r6, r6, #8
                str r6, [r9]
                add r4, #1
                cmp r4, #5
                bne loop

                mov r4, #0
                add r3, #1
                cmp r3, #4 /*N*/
                bne loop
                b berk
#------------------------------------------
ner:
                ldr r0, =matrisA
                mov r2, #4
                mov r3, #0
                mov r4, #0

nerloop:        add r1, r2, #1
                mul r5, r1, r3
                add r5, r5, r4
                lsl r8, r5, #2
                add r9, r0, r8
                ldr r6, [r9]
                lsr r6, r6, #8
                str r6, [r9]
                add r4, #1
                cmp r4, #5
                bne nerloop

                mov r4, #0
                add r3, #1
                cmp r3, #4 /*N*/
                bne nerloop
                bl printstartbracket
                bl printr
                bl printstopbracket
                b end





#-------------------------------------------

printr:         mov r5, #0
print:
                ldr r1, =matrisA
                add r3, r1, r12
                b hexprint

hej2:           add r12, r12, #4
                add r5, #1
                cmp r5, #5
                beq printnewline

newlineklart:
                cmp r12, #80
                bne print
                bx lr


hexprint:
                mov r6, #0xf0
                mov r9, #4
                b hex
hex2:           mov r9, #0
                mov r6, #0xf
hex:            ldr r4, =tabell
                ldr r1, =matrisA
                add r3, r1, r12
                ldr r3, [r3]
                and r8, r3, r6
                lsr r8, r9
                add r8, r8, r4
break:          ldrb r11, [r8]
                ldr r9, =value
                strb r11, [r9]
                mov r1, r9
                mov r2, #1
                mov r0, #1
                mov r7, #4
                swi 0x0
                cmp r6, #0xf0
                beq hex2
                b hej2

#------------------------------------------

printstartbracket:

                ldr r1, =startbracket
                mov r0, #1
                mov r2, #1
                mov r7, #4
                swi 0x0
                bx lr

#-------------------------------------------
printstopbracket:

                ldr r1, =stopbracket
                mov r0, #1
                mov r2, #1
                mov r7, #4
                swi 0x0
                bx lr

#--------------------------------------------
printnewline:

                mov r5, #0
                ldr r1, =newline
                mov r0, #1
                mov r2, #1
                mov r7, #4
                swi 0x0
                b newlineklart

#---------------------------------------------

/*matrix = [2 2 3 4 3; 4 2 3 4 2; 1 2 3 4 1; 1 2 3 4 3];
p=[];

N = 4;



for3 a=1:N+1,
    for2 b=a+1:N,
        for1 k=1:N+1,
            p(k)=(-matrix(a,k)*matrix(b,a))/matrix(a, a);
        end
        for11 k=1:N+1,
            matrix(b,k)=p(k)+matrix(b,k);
        end
    end
end*/


berk:           ldr r0, =matrisA
                ldr r2, =p
                mov r1, #0
for3:
        mov r4, #1
        add r4, r4, r1
        mov r3, r4
        for2:

                mov r4, #0

                mov r12, #0
                for1:
                        ldr r7, =p
                        mov r5, r1
                        mov r6, r4
                        bl matvar
                        mov r8, r6
                        bl negga /*om r8 pos ska det bli neg, om neg ska det bli pos*/
                        mov r5, r3
                        mov r6, r1
                        bl matvar
                        mov r9, r6
                        mul r10, r9, r8
                        cmp r10, #0
                        blt neg2
tbxf2:                  mov r5, r1
                        mov r6, r1
                        bl matvar
                        mov r8, r6
                        cmp r8, #0
                        blt neg3
tbxf3:                  stmdb sp!, {r1-r3}
                        mov r3, r10
                        mov r2, r8
                        bl div
                        cmp r12, #1 /*kollar antal v�rden som gjorts negativa (av täljarr
e och nämnare). Om 1 ska produkten vara neg*/
                        beq neg4
tbxf4:
                        str r1, [r7, r4, lsl #2] /*l�gger utr�knade v�rdet p� sin plats i vektorn p i minnet*/
                        ldmia sp!, {r1-r3}
                        add r4, r4, #1
                        cmp r4, #5
                        bne for1

                        mov r4, #0
                        ldr r7, =p
                for11:
                        mov r5, r3
                        mov r6, r4
                        bl matkorr
                        add r7, r7, #4
                        add r4, r4, #1
                        cmp r4, #5
                        blt for11
        apa:
                add r3, r3, #1
                cmp r3, #4
                blt for2
        add r1, r1, #1
apa2:   cmp r1, #5
        blt for3

        b ner



#-----------------------------
#Tar in rad i r5, kolumn i r6, h�nvisning till plats k i  vekt p i r7. Korrigerar matrisen.

matkorr:        stmdb sp!, {r0-r4, r8-r12}
                mov r8, #0
                ldr r1, =matrisA
                mov r0, #5 /*N+1*/
                mul r2, r0, r5
                add r8, r2, r6
                ldr r9, [r1, r8, lsl #2]
                ldr r10, [r7]
                add r11, r9, r10 /*matrix(b,k)=p(k)+matrix(b,k)*/
                str r11, [r1, r8, lsl #2]
                ldmia sp!, {r0-r4, r8-r12}
                bx lr












#Tar in rad i r5, kolumn i r6. Returnerar matrispositionens v�rde i r6

matvar:
         stmdb sp!,{r0-r4,r7-r12}
        ldr r1, =matrisA
        mov r0, #5 /*N+1*/
        mul r2, r0, r5
        add r8, r2, r6
        mov r10, #4
        mul r9, r8, r10 /*ska flytta fyra bytes, dvs 1 word*/
        add r1, r1, r9 /*pekar på elementet*/
        ldr r6, [r1]
        ldmia sp!,{r0-r4,r7-r12}
        bx lr


negga:
        neg r8, r8
        bx lr

neg2:
        neg r10, r10
        add r12, r12, #1
        b tbxf2

neg3:
        neg r8, r8
        add r12,r12, #1
        b tbxf3

neg4:
        neg r1, r1
        b tbxf4









end:
                mov r7, #1
                swi 0x0




