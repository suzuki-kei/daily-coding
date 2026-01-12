
: fizz_buzz ( n -- c-addr u )
    %00
    over 3 mod 0 = if %01 or endif
    over 5 mod 0 = if %10 or endif

    case
        %00 of s>d <# #s #> endof
        %01 of drop s" Fizz" endof
        %10 of drop s" Buzz" endof
        %11 of drop s" FizzBuzz" endof
    endcase
;

: print_fizz_buzz_values_range recursive ( max min -- )
    over over < if
        drop drop
    else
        dup fizz_buzz
        3 pick 3 pick > if s"  " s+ endif type
        1 + recurse
    endif
;

: print_fizz_buzz_values ( n -- )
    s\" fizz buzz values:\n" type
    1 print_fizz_buzz_values_range
    s\" \n" type
;

