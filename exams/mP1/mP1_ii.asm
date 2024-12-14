MOVING n:
    PUSH B
    PUSH C
    PUSH H
    PUSH L
    MVI A,n
    CMP 01H
    JZ n_1
    CMP 02H
    JZ n_2
    CMP 03H
    JZ n_3
    CMP 04H
    JZ n_4
    RET
    N_1:
    MOV A,B
    ret
    N_2:
    MOV A,C
    ret
    N_3:
    MOV A,H
    ret
    N_4:
    MOV A,L
    Ret
    END