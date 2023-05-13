
: _factorial recursive ( fn n -- fn )
    dup 0 = if
        drop        ( fn n -- fn )
    else
        dup rot *   ( fn n -- n n*fn )
        swap 1 -    ( n n*fn -- n*fn n-1 )
        _factorial  ( n*fn n-1 -- fn )
    endif
;

: factorial ( n -- fn )
    1 swap      ( n -- 1 n )
    _factorial  ( 1 n -- fn )
;

: _show_factorials recursive ( max min -- )
    over over < if
        drop drop
    else
        dup factorial .
        1 +
        _show_factorials
    endif
;

: show_factorials ( n -- )
    s\" factorials:\n" type
    1 _show_factorials
    s\" \n" type
;

