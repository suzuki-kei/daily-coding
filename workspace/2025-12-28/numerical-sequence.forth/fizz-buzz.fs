
: fizz_buzz ( n -- c-addr u )
    ( n -- n flag )
    %00
    over 3 mod 0 = if %01 or endif
    over 5 mod 0 = if %10 or endif

    ( n flag -- c-addr u )
    case
        %00 of s>d <# #s #> endof
        %01 of drop s" Fizz" endof
        %10 of drop s" Buzz" endof
        %11 of drop s" FizzBuzz" endof
    endcase
;

: print_fizz_buzz_values_range ( max min -- )
    over over = if
        drop drop           ( max min -- )
    else
        dup                 ( max min -- max min n )
        fizz_buzz           ( max min n -- max min c-addr u )
        type                ( max min c-addr u -- max min )
        over over           ( max min -- max min max min )
        > if ."  " endif    ( max min max min -- max min )
        1 +                 ( max min -- max min+1 )
        recurse
    endif
;

: print_fizz_buzz_values ( n -- )
    s\" fizz buzz values:\n" type
    1                               ( n -- max=n min )
    print_fizz_buzz_values_range    ( max=n min -- )
    s\" \n" type
;

