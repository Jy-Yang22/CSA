.MODEL SMALL
.STACK 100
.DATA
	OP DB ?
	OPAD DB ?
	QTY DB ?
	DQTY DB 0
	SUB_T DW 0
	ST_Float DB ?
	ST_DEC DB ?
	T_Float DB ?
	T_DEC DB ?
	D_Float DB ?
	D_DEC DB ?
	FT_Float DB ?
	FT_DEC DB ?
	Fprice DW ?
	Float_T DB ?
    DEC_T DB ?
	Tprice DW ?
	Dprice DW ?
	DIST DB 6
	STRLUSER LABEL BYTE   ;user123
    MAXN1 DB 30   ;Max length
    ACTN1 DB ? ; real length 
    INPUTLUSER DB 30 DUP("$")  ;user123$$$$$$$$$$$$$$$$$$$$$$$$$
	STRLPASS LABEL BYTE
    MAXN2 DB 30
	ACTN2 DB ?
    INPUTLPASS DB 30 DUP("$")
	R_USER LABEL BYTE
	MAXN3 DB 30
	ACTN3 DB ?
	INPUTRSTR DB 30 DUP("$")
	R_PASS LABEL BYTE
	MAXN4 DB 30
	ACTN4 DB ?
	INPUTRSTR2 DB 30 DUP("$")
	USERNAME DB 'u','s','e','r','1','2','3'
	PASSWORD DB '1','2','3','u','s','e','r'
	point DB ".$"
	HUNDRED DB 100
	TEN DB 10
	SIX DB 6
	P_B1 DB ?
	P_B2 DB ?
	P_B3 DB ?
	P_B4 DB ?
	P_B5 DB ?
	P_B6 DB ?
	W_MSG DB 0DH,0AH,"===========================Welcome to BookWorm!============================== $"
	USR DB 0DH,0AH,"Enter username(max 30) :$"
	PASS DB 0DH,0AH,"Enter password(max 30):$"
	NUSR DB 0DH,0AH,"Enter new username(max 30) :$"
	NPASS DB 0DH,0AH,"Enter new password(max 30):$"
	MENU3 DB 0DH,0AH,0DH,0AH,"===========================All Product List==================================$"
	STR_MSG1 DB 0DH,0AH,"Your selection : $"
	STR_Quantity DB 0DH,0AH,"Quantity : $"
	B1 DB 0DH,0AH,"1. Secrets of Divine Love: A Spiritual Journey (RM 45) $"  
	B2 DB 0DH,0AH,"2. Demon Slayer Kimetsu No Yaiba (RM 20) $"
	B3 DB 0DH,0AH,"3. Star Wars: Light of the Jedi (RM 50) $"
	B4 DB 0DH,0AH,"4. Oxford Grammar for EAP (RM 60) $"
	B5 DB 0DH,0AH,"5. The Queen's Gambit (RM 30) $"
	B6 DB 0DH,0AH,"6. Dead Lies Dreaming (RM 55) $"
	B7 DB 0DH,0AH,"7. EXIT $"
	s_num DB 1,2,3,4,5,6
	Option1 DB 0DH,0AH,"Select the book you want to add in your cart(1-7) : $"
	Option2 DB 0DH,0AH,"Enter the quantity(1-9) : $"
	Option3 DB 0DH,0AH,"Enter your selection(1-2) : $"
	Option4 DB 0DH,0AH,"Arrange book by ascending or descending order(a=ascending d=descending) : $"
	confirm DB "Y"
	Nconfirm DB "N"
	C_MSG1 DB 0DH,0AH,"Do you have account?(Y=yes/N=no) : $"
	C_MSG2 DB 0DH,0AH,"Confirm to add the book to the cart?(Y=yes/N=no) : $"
	C_MSG3 DB 0DH,0AH,"Add other book?(Y=yes/N=no) : $"
	C_MSG4 DB 0DH,0AH,"Do you want to make a new order?(Y=yes/N=no) : $"
	I_MSG1 DB 0DH,0AH,0DH,0AH, "Invalid option. Please type Y or N.$"
	I_MSG2 DB 0DH,0AH,0DH,0AH, "Invalid input. Please key in a or d.$"
	I_MSG3 DB 0DH,0AH,0DH,0AH, "Invalid selection. Please key in from 1 to 7 based on the menu.$"
	I_MSG4 DB 0DH,0AH,0DH,0AH, "Invalid input. Please key in from quantity range 1 to 9.$"
	E_MSG DB 0DH,0AH,"Invalid username, type again$"
	E_MSG2 DB 0DH,0AH,"Invalid password, type again$"
	S_MSG DB 0DH,0AH,"Account Succesfully Create. Please login the account. $"
	Q_MSG DB 0DH,0AH,0DH,0AH,"Thank you for using our system!$"
	OrderMAX DB 0DH,0AH,"Order MAX RM255. $"
	OrderCancel DB 0DH,0AH,"Order Canceled. $"
	MSG_Continue DB 0DH,0AH,"<<Press any key to restart order>>. $"
	MSG_C2 DB 0DH,0AH, "<<Press any key to continue>>$"
	SMM DB 0DH,0AH,"                             SUMMARY of ORDER $"
	STAR DB 0DH,0AH,"*******************************************************************************$"
	LINE DB 0DH,0AH,"===============================================================================$"
	ITEM DB 0DH,0AH,"Item			         QTY  			 PRICE(RM)$"
	SMM3 DB 0DH,0AH,"SUBTOTAL Of ALL BooK At Cart     $"
	SMM4 DB 0DH,0AH,"Total Service Tax                6% $"
	SMM5 DB 0DH,0AH,"Total Discount Offered           $"
	SMM6 DB "10%$"
	SMM7 DB "0%$"
	SMM8 DB 0DH,0AH,"GrandTotal                                                $"
	space DB "                       $"
	zero DB "00$"
	NL DB 0DH,0AH,"$" 


.CODE
MAIN PROCeeee
	MOV AX,@DATA
	MOV DS,AX


RL_MENU:
	;CLear Screen
	MOV AH,0
	MOV AL,2
	INT 10H

	MOV AH,09H
	LEA DX,W_MSG ;DO you have a acount?
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,C_MSG1
	INT 21H

	;TO get the input about Y or N to confirm jmp to login or register
	MOV AH,01H
	INT 21H
	CMP AL,confirm  ;IF AL == confirm('Y')
	JE Login
	CMP AL,Nconfirm ;IF AL == Nconfirm('N')
	JNE Error
	JMP REG

Error:
	MOV AH,09H
	LEA DX,I_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,MSG_C2
	INT 21H
	MOV AH,01H
	INT 21H
	JMP RL_MENU

Login:
	MOV AH,09H
	LEA DX,USR
	INT 21H

	;GET the input about username
	MOV AH,0AH
	LEA DX,STRLUSER
	INT 21H

	MOV AH,09H
	LEA DX,PASS
	INT 21H

	;GET the input about password
	MOV AH,0AH
	LEA DX,STRLPASS
	INT 21H

	;CMP the input(username) length same with the length of the predefined username
	CMP ACTN1,7
	JNE CHECKLENGTH ;If not same, jmp to checklength to check with the length of register username
	MOV CH,0   
	MOV CL,ACTN1 
	MOV SI,0 

CHECKUSER:  ;Input Login username compare with predefined username
	;MOVE predefined username to AL for checking
	MOV AL,USERNAME[SI] ;u
	CMP INPUTLUSER[SI],AL ;user
	JNE CHECKLENGTH ;If one of the character not same, jmp to check with the register username
	INC SI
LOOP CHECKUSER

;CMP the input(password) length same with the length of the predefined password
CMP ACTN2,7 
JNE CHECKLENGTH2 ;If not same, jmp to CHECKLENGTH2 to check with the length of register password
MOV CH,0
MOV CL,ACTN2
MOV SI,0

CHECKPASS:  ;Input login password compare with predefined password
	;MOVE predefined password to AL for checking
	MOV AL,PASSWORD[SI]
	CMP INPUTLPASS[SI],AL
	JNE CHECKLENGTH2  ;If one of the character not same, jmp to check with the register password
	INC SI
LOOP CHECKPASS
JMP MENU

CHECKLENGTH: ;Compare login input username(ACTN1) length with register input username length(ACTN3)
	MOV BL,ACTN3    
	CMP ACTN1,BL  
	JNE Error1
	MOV CH,0
	MOV CL,ACTN1   ;CL loop times
	MOV SI,0

CHECKUSER2: ;Compare login input username(INPUTLUSER) with register input username(INPUTRSTR)
	MOV AL,INPUTRSTR[SI]
	CMP INPUTLUSER[SI],AL
	JNE Error1
	INC SI
LOOP CHECKUSER2

CHECKLENGTH2:	 ;Compare login input password length(ACTN2) with register input password length(ACTN4)
	MOV BL,ACTN4
	CMP ACTN2,BL
	JNE Error2
	MOV CH,0
	MOV CL,ACTN2
	MOV SI,0

CHECKPASS2:
	MOV AL,INPUTRSTR2[SI]
	CMP INPUTLPASS[SI],AL
	JNE Error2
	INC SI
LOOP CHECKPASS2
JMP MENU

Error1:
	MOV AH,09H
	LEA DX,E_MSG
	INT 21H
	JMP Login

Error2:
	MOV AH,09H
	LEA DX,E_MSG2
	INT 21H
	JMP Login

REG:
	MOV AH,09H
	LEA DX,NUSR
	INT 21H
	MOV AH,0AH
	LEA DX,R_USER
	INT 21H
	MOV AH,09H
	LEA DX,NPASS
	INT 21H
	MOV AH,0AH
	LEA DX,R_PASS
	INT 21H

	MOV AH,09H
	LEA DX,S_MSG
	INT 21H
	JMP Login

MENU:
	;CLear Screen
	MOV AH,0
	MOV AL,2
	INT 10H

	MOV AH,09H
	LEA DX,MENU3
	INT 21H
	
	MOV AH,09H
	LEA DX,B1
	INT 21H

	MOV AH,09H
	LEA DX,B2
	INT 21H
	
	MOV AH,09H
	LEA DX,B3
	INT 21H
	
	MOV AH,09H
	LEA DX,B4
	INT 21H	

	MOV AH,09H
	LEA DX,B5
	INT 21H

	MOV AH,09H
	LEA DX,B6
	INT 21H

	MOV AH,09H
	LEA DX,B7
	INT 21H

	MOV AH,09H
	LEA DX,Option4
	INT 21H	

	MOV AH,01H
	INT 21H
	MOV OPAD,AL
CompareSAD:
	CMP OPAD,'a'
	JE m_ascending
	CMP OPAD,'d'
	JNE CheckAD
	JMP m_descending

CheckAD:
	MOV AH,09H
	LEA DX,I_MSG2
	INT 21H
	MOV AH,09H
	LEA DX,MSG_C2
	INT 21H
	MOV AH,01H
	INT 21H
	JMP MENU


m_ascending:
	;CLear Screen
	MOV AH,0
	MOV AL,2
	INT 10H

	MOV AH,09H
	LEA DX,MENU3
	INT 21H 

	MOV SI,0
	MOV DI,4

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI] ;1
	ADD DL,30H  
	INT 21H

	MOV AH,09H
	LEA DX,point ;.
	INT 21H

	MOV AH,09H
	LEA DX,B6[DI] ;DEAD.........................
	INT 21H
	MOV P_B1,55
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI] ;2
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point ;.
	INT 21H

	MOV AH,09H
	LEA DX,B2[DI] ;DEMON SLAYER..................
	INT 21H
	MOV P_B2,20
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B4[DI]
	INT 21H
	MOV P_B3,60
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B1[DI]
	INT 21H
	MOV P_B4,45
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B3[DI]
	INT 21H
	MOV P_B5,50
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B5[DI]
	INT 21H
	MOV P_B6,30
	INC SI

	MOV AH,09H
	LEA DX,B7
	INT 21H

	JMP Selection
	

m_descending:
	;CLear Screen
	MOV AH,0
	MOV AL,2
	INT 10H
	MOV AH,09H
	LEA DX,MENU3
	INT 21H 

	MOV SI,0
	MOV DI,4

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B5[DI]
	INT 21H
	MOV P_B1,30
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B3[DI]
	INT 21H
	MOV P_B2,50
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B1[DI]
	INT 21H
	MOV P_B3,45
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B4[DI]
	INT 21H
	MOV P_B4,60
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B2[DI]
	INT 21H
	MOV P_B5,20
	INC SI

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,02H
	MOV DL,s_num[SI]
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,B6[DI]
	INT 21H
	MOV P_B6,55
	INC SI

	MOV AH,09H
	LEA DX,B7
	INT 21H

	
Selection:
	MOV AH,09H
	LEA DX,Option1
	INT 21H	

	MOV AH,01H
	INT 21H
	SUB AL,48
	MOV OP,AL
	CMP OP,0
	JLE Validation
	CMP OP,7
	JE jump1
	CMP OP,6
	JG Validation
	JMP InputQTY

Validation:
	MOV AH,09H
	LEA DX,I_MSG3
	INT 21H
	MOV AH,09H
	LEA DX,MSG_C2
	INT 21H
	MOV AH,01H
	INT 21H
	JMP CompareSAD

jump1:
		jmp CompareS


InputQTY:
	MOV AH,09H
	LEA DX,Option2
	INT 21H	

	MOV AH,01H
	INT 21H
	SUB AL,48
	CMP AL,0
	JLE INVALIDQTY
	CMP AL,9
	JG INVALIDQTY
	MOV QTY,AL
	JMP CHECKOPAD

INVALIDQTY:
	MOV AH,09H
	LEA DX,I_MSG4
	INT 21H
	JMP InputQTY


CHECKOPAD:
	;CLear Screen
	MOV AH,0
	MOV AL,2
	INT 10H

	CMP OPAD,'a'
	JE a_SMM
	CMP OPAD,'d'
	JMP d_SMM

a_SMM:
	MOV SI,5
	CMP OP,1
	JE aSMM1
	CMP OP,2
	JE aSMM2
	CMP OP,3
	JE aSMM3
	CMP OP,4
	JE aSMM4
	CMP OP,5
	JE aSMM5
	CMP OP,6
	JE aSMM6

aSMM1:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B6[SI]
	INT 21H
	JMP DisQTY

aSMM2:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B2[SI]
	INT 21H
	JMP DisQTY

aSMM3:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B4[SI]
	INT 21H
	JMP DisQTY

aSMM4:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B1[SI]
	INT 21H
	JMP DisQTY

aSMM5:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B3[SI]
	INT 21H
	JMP DisQTY

aSMM6:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B5[SI]
	INT 21H
	JMP DisQTY

d_SMM:
	MOV SI,5
	CMP OP,1
	JE dSMM1
	CMP OP,2
	JE dSMM2
	CMP OP,3
	JE dSMM3
	CMP OP,4
	JE dSMM4
	CMP OP,5
	JE dSMM5
	CMP OP,6
	JE dSMM6

dSMM1:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B5[SI]
	INT 21H
	JMP DisQTY

dSMM2:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B3[SI]
	INT 21H
	JMP DisQTY

dSMM3:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B1[SI]
	INT 21H
	JMP DisQTY

dSMM4:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B4[SI]
	INT 21H
	JMP DisQTY

dSMM5:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B2[SI]
	INT 21H
	JMP DisQTY

dSMM6:
	MOV AH,09H
	LEA DX,STR_MSG1
	INT 21H
	MOV AH,09H
	LEA DX,B6[SI]
	INT 21H
	JMP DisQTY






DisQTY:
	MOV AH,09H
	LEA DX,STR_Quantity
	INT 21H
	MOV AH,02H
	MOV DL,QTY
	ADD DL,30H
	INT 21H


C_ADD:	
	MOV AH,09H
	LEA DX,C_MSG2 ;Confirm to add to the cart?
	INT 21H

	MOV AH,01H
	INT 21H
	CMP AL,confirm 'Y'
	JE CompareS
	CMP AL,Nconfirm 'N'
	JNE Validation3
	JMP CompareSAD


Validation3:
	MOV AH,09H
	LEA DX,I_MSG1
	INT 21H
	JMP C_ADD



CompareS:
	CMP OP,1
	JE ST1
	CMP OP,2
	JE ST2
	CMP OP,3
	JE ST3
	CMP OP,4
	JE ST4
	CMP OP,5
	JE ST5
	CMP OP,6
	JE ST6
	JMP FIN
	

ST1:
	MOV AL,P_B1
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX

ST2:
	MOV AL,P_B2
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX

ST3:
	MOV AL,P_B3
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX

ST4:
	MOV AL,P_B4
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX

ST5:
	MOV AL,P_B5
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX
	
ST6:
	MOV AL,P_B6
	MUL QTY
	ADD SUB_T,AX
	JMP CheckMAX


CheckMAX:
	CMP SUB_T,255
	JNG ADDQTY
	SUB SUB_T,AX
	JMP OrderC

ADDQTY:
	MOV AL,QTY
	ADD DQTY,AL
	MOV AH,09H
ADDBOOK:
	LEA DX,C_MSG3
	INT 21H
	MOV AH,01H
	INT 21H
	CMP AL,Nconfirm
	JE  CTax
	CMP AL,confirm
	JNE Validation4
	JMP CompareSAD

OrderC:
	MOV AH,09H
	LEA DX, OrderMAX
	INT 21H

	MOV AH,09H
	LEA DX, OrderCancel
	INT 21H

	MOV AH,09H
	LEA DX,MSG_Continue
	INT 21H

	MOV AH,01H
	INT 21H

	JMP CompareSAD





Validation4:
	MOV AH,09H
	LEA DX,I_MSG1
	INT 21H
	JMP ADDBOOK

CTax:
	;Cal TAX 6%
    MOV AX,SUB_T ;example AX=250
    MUL DIST     ;After mul AX=1500
    MOV Tprice,AX 

CDIS:
	;Cal Discount 10%
	MOV AX,SUB_T ;example AX=250
	;CMP to see the value bigger than 100 or not, if >=100 get 10% else 0%
	CMP AX,100	
	JL D1
    MUL TEN       ;AFTER MUL AX=2500
    MOV Dprice,AX
	JMP CFT
	D1:
		MOV Dprice,0

CFT:
	;Cal GrandTotal
    MOV AX,SUB_T   ;AX=250
    MUL HUNDRED    ;After MUL AX=25000
    ADD AX,Tprice  ;ADD Tprice which is 1500
    SUB AX,Dprice  ;SUM Dprice which is 2500
    MOV Fprice,AX   ;AX=24000

DISPLAYSMM:
	;Clear Screen
	MOV AH,0
	MOV AL,2
	INT 10H
	
	MOV AH,09H
	LEA DX,SMM
	INT 21H

	MOV AH,09H
	LEA DX,STAR
	INT 21H

	MOV AH,09H
	LEA DX,ITEM
	INT 21H

	MOV AH,09H
	LEA DX,LINE
	INT 21H

	
	MOV AH,09H
	LEA DX,SMM3
	INT 21H

	;Display Total Quantity
	MOV AL,DQTY
	MOV AH,0
	DIV TEN
	MOV BX,AX
	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H

	MOV AH,02H
	MOV DL,BH
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,space
	INT 21H

;Display Subtotal
DISPLAY_ST:
	MOV AX,SUB_T  ;example AX=250
	DIV HUNDRED  ;AL=2 ;AH=50
	MOV ST_DEC,AH


	;To detect the BL is one digit or two digit
	MOV BX,AX
	CMP BL,0
	JE D2

	;DISPLAY FIRST DIGIT 
	MOV AH,02H
	MOV DL,BL  	;BL=2
	ADD DL,30H
	INT 21H
	
D2:
	MOV AL,BH ;BH=50
	MOV AH,0
	DIV TEN
	MOV BX,AX ;BL=5 BH=0

	;DISPLAY SECOND DIGIT
	MOV AH,02H
	MOV DL,BL ;5
	ADD DL,30H
	INT 21H

	;DISPLAY THIRD DIGIT
	MOV AH,02H
	MOV DL,BH ;0
	ADD DL,30H
	INT 21H 

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AH,09H
	LEA DX,zero
	INT 21H


	;Display str service tax
	MOV AH,09H
	LEA DX,SMM4
	INT 21H

DISPLAY_TAX:
	;DISPLAY NUMBER TAX
	MOV AX,Tprice ;Example AX=1500
	DIV HUNDRED ;AL=15 AH=30
	MOV T_Float,AL
	MOV T_DEC,AH

	MOV AL,T_Float
	MOV AH,0  ;AL=1 AH=5
	DIV TEN
	MOV BX,AX ;BL=1 BH=5

	MOV AH,09H
	LEA DX,space
	INT 21H

	;To see the BL is one or two digit
	CMP BL,0
	JE S1

	;DISPLAY FIRST DIGIT
	MOV AH,02H
	MOV DL,BL 		;1
	ADD DL,30H
	INT 21H

S1:
	;DISPLAY SECOND DIGIT
	MOV AH,02H
	MOV DL,BH		;5
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AL,T_DEC
	MOV AH,0  ;AL=0 AH=0
	DIV TEN
	MOV BX,AX ;BL=0 BH=0

	;DISPLAY THIRD DIGIT
	MOV AH,02H
	MOV DL,BL 		;0
	ADD DL,30H
	INT 21H

	;DISPLAY FOURTH DIGIT
	MOV AH,02H
	MOV DL,BH 		;0
	ADD DL,30H
	INT 21H

	;DISPLAY STR DISCOUNT
	MOV AH,09H
	LEA DX,SMM5
	INT 21H

	MOV AX,SUB_T
	CMP AX,100
	JL DISPLAY_ZERO

DISPLAY_TEN:
	MOV AH,09H
	LEA DX,SMM6
	INT 21H
	JMP DISPLAY_DIS

DISPLAY_ZERO:
	MOV AH,09H
	LEA DX,SMM7
	INT 21H

DISPLAY_DIS:
	;DISPLAY NUMBER TAX
	MOV AX,Dprice ;Example AX=2500
	DIV HUNDRED ;AL=25 AH=00
	MOV D_Float,AL
	MOV D_DEC,AH

	MOV AL,D_Float
	MOV AH,0  ;AL=2 AH=5
	DIV TEN
	MOV BX,AX ;BL=2 BH=5

	MOV AH,09H
	LEA DX,space
	INT 21H

	;To see the BL is one or two digit
	CMP BL,0
	JE S2

	;DISPLAY FIRST DIGIT
	MOV AH,02H
	MOV DL,BL 		;2
	ADD DL,30H
	INT 21H

S2:
	;DISPLAY SECOND DIGIT
	MOV AH,02H
	MOV DL,BH		;5
	ADD DL,30H
	INT 21H

	MOV AH,09H
	LEA DX,point
	INT 21H

	MOV AL,D_DEC
	MOV AH,0  ;AL=0 AH=0
	DIV TEN
	MOV BX,AX ;BL=0 BH=0

	;DISPLAY THIRD DIGIT
	MOV AH,02H
	MOV DL,BL 		;0
	ADD DL,30H
	INT 21H

	;DISPLAY FOURTH DIGIT
	MOV AH,02H
	MOV DL,BH 		;0
	ADD DL,30H
	INT 21H

	;DISPLAY STR GRAND TOTAL
	MOV AH,09H
	LEA DX,SMM8
	INT 21H

DIS_GT:
	;DIsplay GRANDTOTAL
    MOV AX,Fprice 
    DIV HUNDRED  ;AL=240 AH=00
    MOV FT_Float,AL
    MOV FT_DEC,AH

    MOV AL,FT_Float
    MOV AH,0
    DIV HUNDRED ;BL=2 BH=40
    MOV BX,AX 

    ;CMP to see the BL is 2 or 3 digit
    CMP BL,0
    JE S3

    ;DISPLAY FIRST DIGIT (2)
    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H

S3:
    MOV AL,BH
    MOV AH,0
    DIV TEN   
    MOV BX,AX  ;BL=7 BH=2

    ;DISPLAY SECOND DIGIT (4)
    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H

    ;DISPLAY THIRD DIGIT (0)
    MOV AH,02H
    MOV DL,BH 
    ADD DL,30H
    INT 21H


    MOV AL,FT_DEC
    MOV AH,0     
    DIV TEN
    MOV BX,AX

    ;DISPLAY POINT
    MOV AH,09H
    LEA DX,point
    INT 21H


    ;DISPLAY FOURTH DIGIT (0)
    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H


    ;DISPLAY FIVE DIGIT (0)
    MOV AH,02H
    MOV DL,BH
    ADD DL,30H
    INT 21H

STRBA:
	MOV AH,09H
	LEA DX,C_MSG4
	INT 21H

	MOV AH,01H
	INT 21H
	CMP AL,confirm
	JE BUYAGAIN
	CMP AL,Nconfirm
	JNE Validation5
	JMP FIN

BUYAGAIN:
	MOV SUB_T,0
	MOV DQTY,0
	JMP MENU

Validation5:
	MOV AH,09H
	LEA DX,I_MSG1
	INT 21H
	JMP STRBA


	
FIN:
	MOV AH,09H
	LEA DX,Q_MSG
	INT 21H
	MOV AX,4C00H
	INT 21H
MAIN ENDP
END MAIN