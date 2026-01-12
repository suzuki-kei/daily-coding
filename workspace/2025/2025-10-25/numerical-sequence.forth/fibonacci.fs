
: _fibonacci recursive ( a b n -- fn )
    dup 0 = if
        drop drop
    else
        rot rot tuck + rot ( a b n -- b a+b n )
        1 - recurse
    endif
;

: fibonacci ( n -- fn )
    0 1 rot _fibonacci
;

: print_fibonacci_numbers_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fibonacci .
        1 + recurse
    endif
;

: print_fibonacci_numbers ( n -- )
    s\" fibonacci numbers:\n" type
    0 print_fibonacci_numbers_range
    s\" \n" type
;

