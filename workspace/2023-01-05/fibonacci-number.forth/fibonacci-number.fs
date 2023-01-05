
: _fibonacci-numbers recursive ( a b n -- )
    dup 0 = if
        drop drop drop      ( a b n -- )
    else
        1 -                 ( a b n -- a b n-1 )
        rot rot             ( a b n-1 -- n-1 a b )
        over .
        tuck                ( n-1 a b -- n-1 b a b )
        +                   ( n-1 b a b -- n-1 b a+b )
        rot                 ( n-1 b a+b -- b a+b n-1 )
        _fibonacci-numbers
    endif
;

: fibonacci-numbers ( n -- )
    0 swap              ( n -- 0 n )
    1 swap              ( 0 n -- 0 1 n )
    _fibonacci-numbers
;

20 fibonacci-numbers

