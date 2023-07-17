
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

: _show_fibonacci_numbers recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fibonacci .
        1 + _show_fibonacci_numbers
    endif
;

: show_fibonacci_numbers ( n -- )
    s\" fibonacci numbers:\n" type
    0 _show_fibonacci_numbers
    s\" \n" type
;

