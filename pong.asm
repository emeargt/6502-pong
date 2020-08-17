.segment "HEADER"
  .byte "NES"
  .byte $1A
  .byte $01
  .byte %00000000
  .byte $00
  .byte $00
  .byte $00
  .byte $00
  .byte $00,$00,$00,$00,$00

;;;;;;;;;;;;;

.segment "STARTUP"
.segment "ZEROPAGE"

.segment "CODE"

WAITVBLANK:
:
  BIT $2002
  BPL :-
  RTS

RESET:
  SEI		; disable IRQs
  CLD		; disable decimal mode
  LDX #$40
  STX $4017	; disable APU frame IRQ
  LDX #$FF
  TXS		; set up stack
  INX		; increment X => X = 0
  STX $2000	; disable NMI
  STX $2001	; disable rendering
  STX $4010	; disable DMC IRQs

  JSR WAITVBLANK

clrmem:
  LDA #$00
  STA $0000, x
  STA $0100, x
  STA $0200, x
  STA $0400, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  LDA #$FE
  STA $0300, x
  INX
  BNE clrmem

  JSR WAITVBLANK

  LDA #%01000000	; intensify greens
  STA $2001

Forever:
  JMP Forever	; infinite loop

NMI:
  RTI

;;;;;;;;;;;;;;;;

.segment "VECTORS"
  .word NMI	; go to NMI label when NMI happens
		; once per frame if NMI enabled
  .word RESET	; use label RESET when processor first turns on
		; or is reset
  .word 0	; external interrupt IRQ undefined right now

.segment "CHARS"

;;;;;;;;;;;;;;;;
