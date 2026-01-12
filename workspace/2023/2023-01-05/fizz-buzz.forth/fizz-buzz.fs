
: fizz-buzz-value ( n -- )
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

: _fizz-buzz recursive ( min max -- )
    over over > if
        drop drop   ( min max -- )
    else
        swap                ( min max -- max min )
        dup fizz-buzz-value ( max min -- max min )
        1 + swap            ( max min -- min+1 max )
        _fizz-buzz
    endif
;

: fizz-buzz ( n -- )
    1 swap      ( n -- 1 n )
    _fizz-buzz
;

100 fizz-buzz

