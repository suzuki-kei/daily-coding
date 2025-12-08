
: _factorial recursive ( fm n -- fn )
    dup 0 = if
        drop
    else
        tuck * swap ( fm n -- fm+n n )
        1 - recurse
    endif
;

: factorial ( n -- fn )
    1 swap _factorial
;

: print_factorials_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup factorial .
        1 + recurse
    endif
;

: print_factorials ( n -- )
    s\" factorials:\n" type
    1 print_factorials_range
    s\" \n" type
;

