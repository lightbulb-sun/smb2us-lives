.memorymap
defaultslot 0
slotsize $2000
slot 0 $8000
slot 1 $a000
slot 2 $c000
slot 3 $e000
.endme

.rombankmap
bankstotal 145
banksize $10
banks 1
banksize $2000
banks 16
banksize $400
banks 128
.endro

.background "smb2us.nes"

.equ MAX_LIVES          99
.equ NUM_LIVES_PLUS_ONE $04ed
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1-ups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.bank 3 slot 0
.orga $9048
        jsr     handle_one_ups

.orga $9f00
handle_one_ups:
        ; replace original instruction
        inc     NUM_LIVES_PLUS_ONE

        lda     #(MAX_LIVES+2)
        cmp     NUM_LIVES_PLUS_ONE
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; bonus game
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.bank 16 slot 3
.orga $e8cc
        jsr     handle_bonus_game
.orga $e8d1
        lda     #(MAX_LIVES+1)

.orga $ff00
handle_bonus_game:
        ; replace original instruction
        adc     NUM_LIVES_PLUS_ONE

        cmp     #(MAX_LIVES+2)
        rts
