
: _fibonacci recursive ( a b n -- fib_n )
    dup 0 = if
        drop drop   ( a b n -- a )
    else
        rot rot     ( a b n -- n a b )
        tuck        ( n a b -- n b a b )
        +           ( n b a b -- n b a+b )
        rot         ( n b a+b -- b a+b n )
        1 -         ( b a+b n -- b a+b n-1 )
        _fibonacci  ( b a+b n-1 -- fib_n )
    endif
;

: fibonacci ( n -- fib_n )
    0 1         ( n -- n 0 1 )
    rot         ( n 0 1 -- 0 1 n )
    _fibonacci  ( 0 1 n -- fib_n )
;

: _fibonacci-numbers recursive ( min max -- )
    over over   ( min max -- min max min max )
    = if
        drop drop           ( min max -- )
    else
        over                ( min max -- min max min )
        fibonacci           ( min max -- min max fib_min )
        .                   ( min max fib_min -- min max )
        swap 1 + swap       ( min max -- min+1 max )
        _fibonacci-numbers  ( min+1 max -- )
    endif
;

: fibonacci-numbers recursive ( n -- )
    1 swap              ( n -- 1 n )
    _fibonacci-numbers  ( 1 n -- )
;

20 fibonacci-numbers

