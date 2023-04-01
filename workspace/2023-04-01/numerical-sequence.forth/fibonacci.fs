
: _fibonacci recursive ( a b n -- fn )
    dup 0 = if
        drop drop   ( a b n -- a )
    else
        1 -         ( a b n -- a b n-1 )
        rot rot     ( a b n-1 -- n-1 a b )
        tuck +      ( n-1 a b -- n-1 b a+b )
        rot         ( n-1 b a+b -- b a+b n-1 )
        _fibonacci  ( b a+b n-1 -- fn )
    endif
;

: fibonacci ( n -- fn )
    0 1 rot     ( n -- 0 1 n )
    _fibonacci  ( 0 1 n -- fn )
;

: _show_fibonacci_numbers recursive ( max min -- )
    over over < if
        drop drop               ( max min -- )
    else
        dup fibonacci .
        1 +                     ( max min -- max min+1 )
        _show_fibonacci_numbers ( max min+1 -- )
    endif
;

: show_fibonacci_numbers ( n -- )
    0                       ( n -- n 0 )
    _show_fibonacci_numbers ( n 0 -- )
;

