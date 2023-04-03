 .MODEL SMALL
.STACK 100H
.DATA   
    PRIME DB "THE NUMBER IS PRIME$"
    NOPRIME DB "NOT PRIME$"
    LINE DB 0AH,0DH,'$'
    
    
    
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,1
    INT 21H
    
    CALL NEW_LINE
    SUB AL,'0'
    
    CHECK:
    
       CMP AL,2
       JE YES
       CMP AL,3
       JE YES
       CMP AL,5
       JE YES
       CMP AL,7
       JE YES
       
       NO: 
       MOV AH,9
       LEA DX,NOPRIME
       INT 21H
       JMP THEEND
       
       YES:
       MOV AH,9
       LEA DX,PRIME
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
      
        
        





