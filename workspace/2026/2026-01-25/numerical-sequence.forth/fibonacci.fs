
: _fibonacci ( a b n -- fn )
    dup 0 = if
        drop drop   ( a b n -- fn=a )
    else
        rot rot     ( a b n -- n a b )
        tuck + rot  ( n a b -- b+a a n )
        1 -         ( b+a a n -- b+a a n-1 )
        recurse
    endif
;

: fibonacci ( n -- fn )
    0 1 rot     ( n -- a b n )
    _fibonacci  ( a b n -- fn )
;

: print_fibonacci_numbers_range ( max min -- )
    over over < if
        drop drop   ( max min -- )
    else
        dup         ( max min -- max min n )
        fibonacci . ( max min n -- max min )
        1 +         ( max min -- max min+1 )
        recurse
    endif
;

: print_fibonacci_numbers ( n -- )
    s\" fibonacci numbers:\n" type
    0                               ( n -- max=n min )
    print_fibonacci_numbers_range   ( max=n min -- )
    s\" \n" type
;

