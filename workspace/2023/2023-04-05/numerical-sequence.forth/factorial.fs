
: _factorial recursive ( fn n -- fn )
    dup 0 = if
        drop        ( fn n -- fn )
    else
        tuck *      ( fn n -- n fn+n )
        swap        ( n fn+n -- fn+n n )
        1 -         ( fn+n n -- fn+n n-1 )
        _factorial  ( fn+n n-1 -- fn )
    endif
;

: factorial ( n -- fn )
    1 swap      ( n -- 1 n )
    _factorial  ( 1 n -- fn )
;

: _show_factorials recursive ( max min -- )
    over over < if
        drop drop           ( max min -- )
    else
        dup factorial .
        1 +                 ( max min -- max min+1 )
        _show_factorials    ( max min+1 -- )
    endif
;

: show_factorials ( n -- )
    1
    _show_factorials
;

