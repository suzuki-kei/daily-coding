
: fizz_buzz ( n -- )
    dup 15 mod 0 = if
        drop s" FizzBuzz "
    else
        dup 5 mod 0 = if
            drop s" Buzz "
        else
            dup 3 mod 0 = if
                drop s" Fizz "
            else
                s>d <# #s #> pad place
                s"  " pad +place
                pad count
            endif
        endif
    endif
;

: print_fizz_buzz_values_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fizz_buzz type
        1 + print_fizz_buzz_values_range
    endif
;

: print_fizz_buzz_values ( n -- )
    s\" fizz buzz values:\n" type
    1 print_fizz_buzz_values_range
    s\" \n" type
;

