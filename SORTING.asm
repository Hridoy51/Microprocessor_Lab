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
    
     
  
    START:
      MOV DI,0 
      
      PROCEDURE:
      
      MOV CL ,INPUT_STR[DI]
      PUSH DI  
      INC DI
      CMP DI,SI
      JE FIRST
      MOV CH,INPUT_STR[DI]
      CMP CL,CH
      JG SWAP
      
      JMP PROCEDURE
      
      
    SWAP:
        MOV INPUT_STR[DI],CL
        POP DI
        MOV INPUT_STR[DI],CH
        INC DI
        JMP PROCEDURE
        
    FIRST:
          DEC SI
          CMP SI,2
          JL FINISHED
          JMP START
          
    FINISHED: 
        MOV AH,9
        LEA DX,INPUT_STR
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
      
        
        
