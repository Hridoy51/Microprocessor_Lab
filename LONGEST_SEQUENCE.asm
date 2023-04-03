.MODEL SMALL
.STACK 100H
.DATA
    INP DB 40 DUP('$')
    NEWLINE DB 0AH,0DH,'$'
    COUNT DB 1
    MAXCOUNT DB 0
    LOW DW ?
    HIGH DW ?
.CODE 
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,1
    MOV SI,0
    
    TAKE_INP:
        INT 21H
        CMP AL,0DH
        JE INP_F
        MOV INP[SI],AL
        INC SI
        JMP TAKE_INP
    INP_F:
        LEA DX,NEWLINE
        MOV AH,9
        INT 21H
        
        MOV SI,0
    CHECK:
        MOV BL,INP[SI]
        CMP BL,'$'
        JE CHECK_F
        INC SI 
        MOV BH,INP[SI]
        DEC BH
        CMP BH,BL
        JNE CNG
        ADD COUNT,1
        JMP CHECK
         
        
    CNG:
        
       MOV CH,MAXCOUNT
       MOV CL, COUNT
       CMP CL,CH
       JG SWAP
       MOV COUNT,1
       JMP CHECK
       
       SWAP:
        PUSH SI
        MOV MAXCOUNT,CL 
        DEC SI
        MOV HIGH,SI
        XOR CH,CH
        SUB SI,CX
        MOV LOW,SI
        ADD LOW,1
        POP SI
        MOV COUNT,1
        JMP CHECK
        
    CHECK_F:
        MOV SI,LOW 
        MOV DI,HIGH 
        MOV AH,2
        PRINT:
            CMP SI,DI
            JG EXIT
            MOV DL,INP[SI]
            INT 21H
            INC SI
            JMP PRINT
        EXIT:
            
   END MAIN     