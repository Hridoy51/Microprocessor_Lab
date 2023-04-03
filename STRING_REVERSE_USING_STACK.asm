.MODEL SMALL
.STACK 100H
.DATA 
   
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
        PUSH AX
        INC SI
        JMP INPUT
        
    INPUT_END:
       
        CALL NEW_LINE 
        MOV CX,SI
        
    PRINT:
         MOV AH,2
         POP DX
         INT 21H
         LOOP PRINT
         
   
    JMP EXIT:
        
        
    NEW_LINE PROC
        PUSH AX
        PUSH DX
         MOV AH,9
         LEA DX,LINE 
         INT 21H
         POP DX
         POP AX
         RET
         
    NEW_LINE ENDP
    EXIT:
    
    END MAIN
        
        