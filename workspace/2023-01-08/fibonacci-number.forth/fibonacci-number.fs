
: _fibonacci recursive ( a b n -- )
    dup 0 = if
        drop drop drop  ( a b n -- )
    else
        rot rot         ( a b n -- n a b )
        over .
        tuck +          ( n a b -- n b a+b )
        rot 1 -         ( n b a+b -- b a+b n-1 )
        _fibonacci
    endif
;

: fibonacci ( n -- )
    0 1 rot     ( n -- 0 1 n )
    _fibonacci
;

20 fibonacci

