
: show_fizzbuzz_value ( n -- )
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

: _show_fizzbuzz_values recursive ( max min -- )
    over over < if
        drop drop
    else
        dup show_fizzbuzz_value
        1 +
        _show_fizzbuzz_values
    endif
;

: show_fizzbuzz_values ( n -- )
    s\" FizzBuzz values:\n" type
    100 1 _show_fizzbuzz_values
    s\" \n" type
;

