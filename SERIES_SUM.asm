.MODEL SMALL
.STACK 100H
.DATA   
    
    LINE DB 0AH,0DH,'$'
    
    
    
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,1
    INT 21H
    
    CALL NEW_LINE
    MOV DL,0
    SUB AL,'0'
    
    SUM:
        ADD DL,AL
        DEC AL
        CMP AL,-1
        JE PRINT
        JMP SUM
        
    
    
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
    
    PRINT:
        ADD DL,'0'
        MOV AH,2
        INT 21H   
        
   
        
    THEEND:
    END MAIN   
      
        
        





