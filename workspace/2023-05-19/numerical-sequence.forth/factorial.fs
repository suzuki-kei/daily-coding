
: _factorial recursive ( fn n -- fn )
    dup 0 = if
        drop
    else
        tuck * swap
        1 -
        _factorial
    endif
;

: factorial ( n -- fn )
    1 swap
    _factorial
;

: _show_factorials recursive ( max min -- )
    over over < if
        drop drop
    else
        dup factorial .
        1 + _show_factorials
    endif
;

: show_factorials ( n -- )
    s\" factorials:\n" type
    1 _show_factorials
    s\" \n" type
;

