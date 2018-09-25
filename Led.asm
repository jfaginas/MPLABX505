;-------------------------------------------------------------------------------
	LIST	    p = P16F84A
	INCLUDE	    <p16F84.inc>
	__CONFIG    _XT_OSC & _PWRTE_ON & _WDT_OFF & _CP_OFF
	ERRORLEVEL  -302
;-------------------------------------------------------------------------------
#DEFINE	bank0	bcf	STATUS,RP0
#DEFINE	bank1	bsf	STATUS,RP0	

LED	EQU	7
;-------------------------------------------------------------------------------	
	CBLOCK	    0X0C
	d1
	d2
	ENDC
	
;-------------------------------------------------------------------------------	
	ORG	    0x000
	clrw
	goto	    Main
	
	ORG	    0x004
	retfie
;-------------------------------------------------------------------------------	
Main
	bank1
	clrf	    TRISB
	movlw	    b'11111'
	movwf	    TRISA
	bank0
Loop
	bsf	    PORTB,LED
	call	    delay_100ms
	bcf	    PORTB,LED
	call	    delay_50ms
	goto	    Loop
	
;-------------------------------------------------------------------------------	
delay_1ms
	movlw	    .250
	movwf	    d1
	nop
	decfsz	    d1,F
	goto	    $-2
	return
	
delay_100ms
	movlw	    .100
	movwf	    d2
	call	    delay_1ms
	decfsz	    d2,F
	goto	    $-2
	return
delay_50ms
	movlw	    .50
	movwf	    d2
	call	    delay_1ms
	decfsz	    d2,F
	goto	    $-2
	return	
;-- FIN ------------------------------------------------------------------------	
	END
	
