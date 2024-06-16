.model small
.data
        hex_num dw 4D2h
        bcd_num dw 0
.code
        mov ax, @data           ;initialize data segment
        mov ds, ax

        mov ch, 00h             ;digit counter
        mov bx, 0ah             ;division factor
        mov ax, hex_num         ;load hex number
rpt:
        mov dx, 00
        div bx                  ;divide it by 10
        push dx                 ;store remainder on satck
        inc ch                  ;increment digit counter
        cmp ax, 0ah             ;compare quotient with 10
        jge rpt                 ;if quotient > 10 then repeat divsion operation
        inc ch                  ;increment digit counter at last
        mov cl, 12              ;initialize shift counter
rpt1:
        and ax, 0fh             ;mask lower nibble
        shl ax, cl              ;shift digit to appropriate position
        add bcd_num, ax         ;add with bcd_num
        sub cl, 4               ;decrement shift counter
        pop ax                  ;read next BCD digit
        dec ch                  ;decremnet digit counter
        jnz rpt1                ;is digit != last digit then repeat same shift and add operation

        mov ah, 4ch             ;terminate program and exit to dos
        int 21h
ends
end
