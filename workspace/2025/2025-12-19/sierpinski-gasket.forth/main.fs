
: print_sierpinski_gasket_row recursive ( width y x -- width y )
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

: print_sierpinski_gasket_rows recursive ( height width y -- height width )
    2 pick over = if
        drop
    else
        0 print_sierpinski_gasket_row
        1 + recurse
    endif
;

: print_sierpinski_gasket ( height width -- )
    0 print_sierpinski_gasket_rows
    drop drop
;

: main ( -- )
    32 32 print_sierpinski_gasket
    bye
;

