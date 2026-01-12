
: fizz-buzz-value ( n -- x_n )
    dup 15 mod 0 = if
        s" FizzBuzz " type drop
    else
        dup 5 mod 0 = if
            s" Buzz " type drop
        else
            dup 3 mod 0 = if
                s" Fizz " type drop
            else
                .
            endif
        endif
    endif
;

: _fizz-buzz recursive ( min max -- )
    over over           ( min max -- min max min max )
    > if
        drop drop       ( min max -- )
    else
        over            ( min max -- min max min )
        fizz-buzz-value ( min max min -- min max x_min )
        \ .               ( min max x_min -- min max )
        over 1 + swap   ( min max -- min+1 max )
        _fizz-buzz      ( min+1 max -- )
    endif
;

: fizz-buzz ( n -- )
    1 swap      ( n -- 0 n )
    _fizz-buzz  ( 0 n -- )
;

100 fizz-buzz

