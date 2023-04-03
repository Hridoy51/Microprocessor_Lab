.MODEL SMALL
.STACK 100H

.DATA
    input DB 40 DUP('$') 
    LINE DB 0AH,0DH,'$' 
    
.CODE
    
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    MOV SI,0
    INPUTSTART:
        MOV AH,1 
        INT 21H
        CMP AL,0DH
        JE EINPUT
        MOV input+SI , AL 
        INC SI
        JMP INPUTSTART
        
     EINPUT:
        CALL NEWLINE
        MOV SI,0  
     
     CHANGECASE:
        MOV DL,input+SI 
        CMP DL,'$'
        JE PRINTSTRING
        CMP DL,'A'
        JL NOCHANGE
        CMP DL,'Z'
        JG  CHECKLOW
        XOR DL,32
        JMP NOCHANGE 
        
        CHECKLOW:
            CMP DL,'a'
            JL NOCHANGE
            CMP DL,'z'
            JG NOCHANGE
            XOR DL,32
            JMP NOCHANGE
            
        NOCHANGE:
            MOV input+SI,DL
            INC SI
            JMP CHANGECASE 
            
        
            
        PRINTSTRING: 
                
              LEA DX,input
              MOV AH,9
              INT 21H  
              MOV AH, 4CH
              INT 21H 
        
               
         
        NEWLINE PROC 
        LEA DX,LINE
        MOV AH,9
        INT 21H   
        RET
        NEWLINE ENDP
        
       
        
    
END MAIN  

    