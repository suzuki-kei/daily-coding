
: fibonacci++ recursive ( n a b -- fib_n )
    rot                 ( n a b -- a b n )

    dup 0 = if
        drop drop       ( a b n -- a )
    else
        1 - rot rot     ( a b n -- n-1 a b )
        tuck +          ( n a b -- n b a+b )
        fibonacci++
    endif
;

: fibonacci ( n -- x )
    0 1         ( n -- n a b )
    fibonacci++ ( n a b -- fib_n )
;

: fibonacci-numbers recursive ( min max -- fib_1 fib_2 ... )
    over over > if
        drop drop           ( min max -- )
    else
        over fibonacci      ( min max -- min max fib_n )
        dup .
        rot 1 + rot         ( min max fib_n -- fib_n min+1 max )
        fibonacci-numbers
    endif
;

1 10 fibonacci-numbers

