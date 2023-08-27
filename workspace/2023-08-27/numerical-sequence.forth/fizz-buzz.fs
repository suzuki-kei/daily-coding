
: print_fizz_buzz_value ( n -- )
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

: _print_fizz_buzz_values recursive ( max min -- )
    over over < if
        drop drop
    else
        dup print_fizz_buzz_value
        1 + _print_fizz_buzz_values
    endif
;

: print_fizz_buzz_values ( n -- )
    s\" fizz buzz values:\n" type
    1 _print_fizz_buzz_values
    s\" \n" type
;

