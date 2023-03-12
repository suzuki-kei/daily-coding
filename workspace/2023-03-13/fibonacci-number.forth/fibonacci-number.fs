
: _fibonacci recursive ( a b n -- fn )
    dup 0 = if
        drop drop . ( a b n -- )
    else
        1 -         ( a b n -- a b n-1 )
        rot rot     ( a b n-1 -- n-1 a b )
        over .
        tuck +      ( n-1 a b -- n-1 b a+b )
        rot         ( n-1 b a+b -- b a+b n-1 )
        _fibonacci  ( b a+b n-1 -- )
    endif
;

: fibonacci ( n -- fn )
    0 1 rot     ( n -- 0 1 n )
    _fibonacci  ( 0 1 n -- fn )
;

20 fibonacci

