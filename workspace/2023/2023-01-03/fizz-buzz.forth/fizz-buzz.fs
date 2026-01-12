
: fizz-buzz-value ( n -- x )
    dup 15 mod 0 = if
        drop
        s" FizzBuzz " type
    else
        dup 5 mod 0 = if
            drop
            s" Buzz " type
        else
            dup 3 mod 0 = if
                drop
                s" Fizz " type
            else
                .
            endif
        endif
    endif
;

: fizz-buzz-range recursive ( min max -- x_min ... x_max )
    over over <= if
        over fizz-buzz-value    ( min max -- min max x )
        swap 1 + swap           ( min max -- min+1 max )
        fizz-buzz-range
    else
        drop drop               ( min max -- )
    endif
;

: fizz-buzz ( n -- x_1 x_2 ... x_n )
    1 swap fizz-buzz-range
;

100 fizz-buzz

