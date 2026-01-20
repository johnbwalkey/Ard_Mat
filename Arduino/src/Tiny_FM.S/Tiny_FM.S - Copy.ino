;---------------
; Assembly Code
;---------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global delay_ms
;=======================================================================
delay_ms:             ;for CLK = 8 MHz
    LDI   R21, 255    ;R23=10-->0.25s, R23=21-->0.5s, R23=42-->1s,...etc
l1: LDI   R22, 255
l2: LDI   R23, 10
l3: DEC   R23
    BRNE  l3
    DEC   R22
    BRNE  l2
    DEC   R21
    BRNE  l1
    RET
