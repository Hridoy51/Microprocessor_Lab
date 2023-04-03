.MODEL SMALL
.STACK 100H
.DATA   
    INPUT_STR DB 40 DUP('$')
    LINE DB 0AH,0DH,'$'
    NO_CAPITAL DB "NO CAPITAL LETTER$"
    FLAG DB 0
    
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV BH ,65
    MOV BL ,91
    
    MOV AH,1
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
    PROCEDURE:
      MOV CL ,INPUT_STR+SI
      INC SI  
      CMP CL,'$'
      JE EXIT
      CMP CL,'A'
      JGE CHECKLOW
      JMP PROCEDURE
      
      
    CHECKLOW:
        CMP CL,'Z'
        JLE CHECKMAIN
        JMP PROCEDURE
        
        
    CHECKMAIN:
          MOV FLAG,1
          CMP CL,BH
          JG HGI
          MID: 
          CMP  CL,BL
          JL HLI
          JMP PROCEDURE
          
    HGI:
        MOV BH,CL
        JMP MID
        
    HLI:
        MOV  BL,CL 
        JMP PROCEDURE
        
    
    
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
        CMP FLAG,0 
        JE PRINTNO 
        MOV AH,2
        MOV DL,BH
        INT 21H
        MOV DL,BL
        INT 21H
        JMP THEEND
        
        
        
    PRINTNO:
    MOV AH,9 
        LEA DX,NO_CAPITAL
         
        INT 21H
        
    THEEND:
    END MAIN   
      
        
        
