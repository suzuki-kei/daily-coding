
: print_fizz_buzz_value ( n -- )
    dup 15 mod 0 = if
        drop s" FizzBuzz " type
    else
        dup 5 mod 0 = if
            drop s" Buzz " type
        else
            dup 3 mod 0 = if
                drop s" Fizz " type
            else
                .
            endif
        endif
    endif
;

: print_fizz_buzz_values_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup print_fizz_buzz_value
        1 + print_fizz_buzz_values_range
    endif
;

: print_fizz_buzz_values ( n -- )
    s\" fizz buzz values:\n" type
    1 print_fizz_buzz_values_range
    s\" \n" type
;

