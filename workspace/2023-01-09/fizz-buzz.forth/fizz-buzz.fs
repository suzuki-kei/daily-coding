
: fizz-buzz-value ( n -- )
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

: _fizz-buzz recursive ( max min -- )
    over over = if
        drop drop       ( max min -- )
    else
        dup             ( max min -- max min min )
        fizz-buzz-value ( max min min -- max min )
        1 +             ( max min -- max min+1 )
        _fizz-buzz
    endif
;

: fizz-buzz ( n -- )
    1           ( n -- n 1 )
    _fizz-buzz
;

100 fizz-buzz

