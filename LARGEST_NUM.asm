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
        CMP AL,' '
        JE INPUT 
        CMP AL,0DH
        JE INPUT_END
        MOV INP_STR+SI,AL
        INC SI
        JMP INPUT
        
    INPUT_END:
        
        DEC SI
        CALL NEW_LINE 
        MOV DL,'0'
        
    FIND:
        CMP SI,-1
        JE PRINT
        MOV CL,INP_STR[SI]
        DEC SI
        CMP DL,CL
        JL CHNG
        JMP FIND
        
    CHNG:
        MOV DL,CL
        JMP FIND
        
    PRINT:
        MOV AH,2
        INT 21H
        JMP EXIT    
        
    NEW_LINE PROC
         PUSH AX
         PUSH DX
         PUSH CX
         MOV AH,9
         LEA DX,LINE 
         INT 21H
         POP CX
         POP DX
         POP AX
         RET
         
    NEW_LINE ENDP
    EXIT: 
    
    
    END MAIN
        
        