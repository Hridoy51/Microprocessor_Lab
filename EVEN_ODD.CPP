 .MODEL SMALL
.STACK 100H
.DATA   
    EVEN DB "THE NUMBER IS EVEN$"
    ODD DB "ODD NUMBER$"
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
    
       AND AL,00000001
       CMP AL,1
       JE ODDNUM
       
       EVENNUM: 
       MOV AH,9
       LEA DX,EVEN
       INT 21H
       JMP THEEND
       
       ODDNUM:
       MOV AH,9
       LEA DX,ODD
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
      
        
        





