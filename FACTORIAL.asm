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
    
    XOR AH,AH
    SUB AL,'0' 
    MOV CX,AX
    MOV AX,1
    FACTORIAL:
        MUL CX
        LOOP FACTORIAL
    
     ADD AL,'0'
     MOV DL,AL
     MOV AH,2
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
      
        
        
