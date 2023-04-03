.MODEL SMALL
.STACK 100H
.DATA   
    INPUT_STR DB 40 DUP('$')
    LINE DB 0AH,0DH,'$'
    VOWEL DB "AEIOUaeiou$"
    V DB 0
    C DB 0
    D DB 0
    S DB 0
    
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV SI,0
    
    
    INPUT:
        MOV AH,1
        INT 21H 
        CMP AL,0DH
        JE INPUT_END 
        MOV INPUT_STR+SI,AL
        INC SI
        JMP INPUT
        
    INPUT_END:
    CALL NEW_LINE 
    

    
    MOV SI,0
    
    SOL:
        MOV CL,INPUT_STR[SI] 
        INC SI
        CMP CL,'$'
        JE PRINT_ANS
        CMP CL,' '
        JE S_COUNT
        CMP CL,'0'
        JGE CHECK_DIGIT
        D_F:
        
        MOV DI,0
        CHECK_V:
            MOV DL,VOWEL[DI]
            INC DI
            CMP DL,'$'
            JE CHECK_FINISH
            CMP DL,CL
            JE V_COUNT
            JMP CHECK_V
        CHECK_FINISH:
        
        CMP CL,'a'
        JGE CHECK_CON1
        
        C_H:
        CMP CL,'A'
        JGE CHECK_CON2
        
        NOTHING:
        JMP SOL
        
        
    CHECK_DIGIT:
       CMP CL,'9'
       JLE D_COUNT
       JMP D_F 
       
    CHECK_CON1:
        CMP CL,'z'
        JLE C_COUNT
        JMP C_H
    CHECK_CON2:
        CMP CL,'Z'
        JLE C_COUNT
        JMP NOTHING    
       
    S_COUNT:
        ADD S,1
        JMP SOL
            
    V_COUNT:
        ADD V,1
        JMP SOL
    C_COUNT:
        ADD C,1
        JMP SOL
    D_COUNT:
        ADD D,1
        JMP SOL 
        
   PRINT_ANS:
    MOV AH,2
    ADD S,'0'
    MOV DL,S
    INT 21H 
    
    ADD D,'0'
    MOV DL,D
    INT 21H
    
    ADD V,'0'
    MOV DL,V
    INT 21H
    
    ADD C,'0'
    MOV DL,C
    INT 21H
       
    JMP THEEND
    
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
    
        
        
   
        
    THEEND:
    END MAIN   
      
        
        
