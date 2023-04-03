.MODEL SMALL
.STACK 100H
.DATA   
    INPUT_STR DB 40 DUP('$')
    LINE DB 0AH,0DH,'$'
    PATTERN_STR DB 40 DUP('$') 
    NO_PATTERN DB "NO PATTERN FOUND$"
    PATTERN_FOUND DB "PATTERN FOUND$" 
   
    
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
  
    
    MOV AH,1
    MOV SI,0
    
    
    INPUT:
        MOV AH,1
        INT 21H 
        CMP AL,0DH
        JE INPUT_END 
        MOV INPUT_STR[SI],AL
        INC SI
        JMP INPUT
        
    INPUT_END:
    CALL NEW_LINE 
    ;TAKE PATTERN....
    MOV SI,0
    PATTERN:
         MOV AH,1
        INT 21H 
        CMP AL,0DH
        JE PATTERN_END 
        MOV PATTERN_STR+SI,AL
        INC SI
        JMP PATTERN 
        
    PATTERN_END:
    CALL NEW_LINE
    
    MOV SI,0
    MOV DI,0 
    PUSH SI
    CHECK:
       
        MOV DH,INPUT_STR[SI] 
        
        MOV DL ,PATTERN_STR[DI] 
        CMP DL,'$'
        JE PRINTYES
         CMP DH,'$'
        JE PRINTNO
        
        INC SI
        INC DI
        
        CMP DH,DL
        JNE INDEX
        JMP CHECK
        
    INDEX:
        POP SI
        INC SI
        PUSH SI
        MOV DI,0
        JMP CHECK
        
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
    
      
        
    PRINTNO:
    MOV AH,9 
        LEA DX,NO_PATTERN
         
        INT 21H 
        JMP THEEND
        
    PRINTYES:
         MOV AH,9 
        LEA DX,PATTERN_FOUND
         
        INT 21H
        
    THEEND:
    END MAIN   
      
        
        
