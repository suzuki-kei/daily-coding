
: _fibonacci recursive ( a b n -- fn )
    dup 0 = if
        drop drop
    else
        rot rot tuck + rot
        1 - _fibonacci
    endif
;

: fibonacci ( n -- fn )
    0 1 rot _fibonacci
;

: _print_fibonacci_numbers recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fibonacci .
        1 + _print_fibonacci_numbers
    endif
;

: print_fibonacci_numbers ( n -- )
    s\" fibonacci numbers:\n" type
    0 _print_fibonacci_numbers
    s\" \n" type
;

