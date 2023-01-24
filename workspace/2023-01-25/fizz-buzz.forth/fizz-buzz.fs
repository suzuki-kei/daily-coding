
: fizz_buzz_value ( n -- )
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

: _fizz_buzz recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fizz_buzz_value
        1 +
        _fizz_buzz
    endif
;

: fizz_buzz ( n -- )
    1
    _fizz_buzz
;

100 fizz_buzz

