
: print_sierpinski_gasket_row ( height width y x -- height width y )
    2 pick over = if
        drop
        s\" \n" type
    else
        over over and 0 = if
            s" ＊" type
        else
            s" 　" type
        endif
        1 + recurse
    endif
;

: print_sierpinski_gasket_rows ( height width y -- )
    2 pick over = if
        drop drop drop
    else
        0 print_sierpinski_gasket_row
        1 + recurse
    endif
;

: print_sierpinski_gasket ( height width -- )
    0 print_sierpinski_gasket_rows
;

: main ( -- )
    32 32 print_sierpinski_gasket
    bye
;

