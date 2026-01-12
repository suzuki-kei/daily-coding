
: fizz_buzz ( n -- c-addr u )
    dup 15 mod 0 = if
        drop s" FizzBuzz"
    else
        dup 5 mod 0 = if
            drop s" Buzz"
        else
            dup 3 mod 0 = if
                drop s" Buzz"
            else
                s>d <# #s #>
            endif
        endif
    endif
;

: print_fizz_buzz_values_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fizz_buzz s"  " s+ type
        1 + print_fizz_buzz_values_range
    endif
;

: print_fizz_buzz_values ( n -- )
    1 print_fizz_buzz_values_range
    s\" \n" type
;

: main ( -- )
    100 print_fizz_buzz_values
    bye
;

