.MODEL SMALL
.STACK 100H
.DATA 
    INP_STR DB 40 DUP('$')
    LINE DB 0AH,0DH,'$'
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,1
    MOV SI,0
    
    
    INPUT:
        
        INT 21H 
        CMP AL,0DH
        JE INPUT_END
        MOV INP_STR+SI,AL
        INC SI
        JMP INPUT
        
    INPUT_END:
        
        DEC SI
        CALL NEW_LINE
        MOV AH,2
    PRINT_REVERSE:
    
        CMP SI,-1
        JE EXIT
        MOV DL,INP_STR+SI
        DEC SI
        INT 21H
        JMP PRINT_REVERSE
        
        
    NEW_LINE PROC
         MOV AH,9
         LEA DX,LINE 
         INT 21H
         RET
         
    NEW_LINE ENDP
    EXIT:
    
    END MAIN
        
        