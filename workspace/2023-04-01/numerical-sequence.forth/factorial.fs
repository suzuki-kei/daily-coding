
: _factorial recursive ( fn n -- fn )
    dup 0 = if
        drop        ( fn n -- fn )
    else
        dup         ( fn n -- fn n n )
        rot *       ( fn n n -- n n*fn )
        swap        ( n n*fn -- n*fn n )
        1 -         ( n*fn n -- n*fn n-1 )
        _factorial  ( n*fn n-1 -- new_fn )
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
    1                   ( n -- n 1 )
    _show_factorials    ( n 1 -- )
;

