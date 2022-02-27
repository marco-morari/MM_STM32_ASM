;==========================================================================================
; Project:  
; Date:     
; Author:   
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
;  <inserire una breve descrizione del progetto>
;  
;  <specifiche del progetto>
;  <specifiche del collaudo>
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0  01/01/01     Versione iniziale
; <Descrivere per ogni revisione o cambio di versione le modifiche apportate>
; 
;==========================================================================================
		THUMB

;------------------------------------------------------------------------------------------
;=== COSTANTI =============================================================================
;------------------------------------------------------------------------------------------
GPIOB_MODER   EQU 0x48000400
GPIOB_ODR     EQU 0x48000414
GPIOE_MODER   EQU 0x48001000	
GPIOE_ODR     EQU 0x48001014
RCC_CR_AHB2   EQU 0X4002104C

PB2_PORT_AHB2_BIT EQU 0x1
PB2_MODERH_BIT    EQU 0x5
PB2_MODERL_BIT    EQU 0x4
PB2_ODR_BIT       EQU 0x2

;------------------------------------------------------------------------------------------
;=== AREA ISTRUZIONI ======================================================================
;------------------------------------------------------------------------------------------
		AREA MyCode, CODE, READONLY
		ALIGN
		;------------------
		; EXPORT/IMPORT
		;------------------
		EXPORT __main
		ENTRY
    
;------------------------------------------------------------------------------------------
;=== MAIN ROUTINE =========================================================================
;------------------------------------------------------------------------------------------
__main

LedInit

		;LedInit
		; Mettere ad 1 il bit 1 e il bit 4 della word con indirizzo 0x4002104C
		MOV R0, #0x104C
		MOVT R0, #0x4002
		LDRB R1, [R0]
		ORR R1, #0x12
		STRB R1, [R0]
		
		;LedInit
		; Mettere ad 1 il bit 4 e a 0 il bit 5 della word con indirizzo 0x48000400
		MOV R0, #0x400
		MOVT R0, #0x4800
		LDRB R1, [R0]
		ORR R1, #1<<4
		BIC R1, #1<<5
		STRB R1, [R0]
		
		;LedInit
		; Mettere ad 1 il bit 16 e a 0 il bit 17 della word con indirizzo 0x48001000
		MOV R0, #0x1000
		MOVT R0, #0x4800
		LDR R1, [R0]
		ORR R1, #1<<16
		BIC R1, #1<<17
		STR R1, [R0]
		
LedRossoOn

		;LedRossoOn
		; Mettere ad 1 il bit 2 della word di indirizzo 0x48000414
		MOV R0, #0x414
		MOVT R0, #0x4800
		LDRB R1, [R0]
		ORR R1, #0x4
		STRB R1, [R0]
		
LedVerdeOn
		
		;LedVerdeOn
		; Mettere ad 1 il bit 8 della word di indirizzo 0x48001014 
		MOV R0, #0x1014
		MOVT R0, #0x4800
		LDRH R1, [R0]
		ORR R1, #0x100
		STRH R1, [R0]
		
MainLoop
LedOn   ;accensione led verde
		LDR R1, [R0]
		ORR R1, #0x100
		STR R1, [R0]
		
delay
		PUSH{LR}
		MOV R0, #0x93E0
		MOVT R0, #0x4
Ciclo
		SUB r0, #1
		CMP r0, #0
		BNE Ciclo
		POP{LR}
		BX LR
		;fine delay
		
LedOff  ;spegnimento led verde
		LDR R1, [R0]
		BIC R1, #0x100
		STR R1, [R0]
		
		BL delay
		B MainLoop
stop B stop
;------------------------------------------------------------------------------------------
		ALIGN
		END
;------------------------------------------------------------------------------------------


