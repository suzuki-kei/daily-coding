
: fizz-buzz-value ( i -- )
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

: _fizz-buzz recursive ( i n -- )
    dup 0 = if
        drop drop       ( i n -- )
    else
        over            ( i n -- i n i )
        fizz-buzz-value ( i n i -- i n )
        1 - swap        ( i n -- n-1 i )
        1 + swap        ( n-1 i -- i+1 n-1 )
        _fizz-buzz
    endif
;

: fizz-buzz ( n -- )
    1 swap      ( n -- 1 n )
    _fizz-buzz
;

100 fizz-buzz

