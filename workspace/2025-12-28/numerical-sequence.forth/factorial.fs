
: _factorial ( fm n -- fn )
    dup 0 = if
        drop    ( fm n -- fn=fm )
    else
        tuck    ( fm n -- n fm n )
        *       ( n fm n -- n fm*n )
        swap    ( n fm*n -- fm*n n )
        1 -     ( fm*n n-1 )
        recurse
    endif
;

: factorial ( n -- fn )
    1           ( n -- n fm )
    swap        ( n fm -- fm n )
    _factorial  ( fm n -- fn )
;

: print_factorials_range ( max min -- )
    over over = if
        drop drop   ( max min -- )
    else
        dup         ( max min -- max min n )
        factorial . ( max min n -- max min )
        1 +         ( max min -- max min+1 )
        recurse
    endif
;

: print_factorials ( n -- )
    s\" factorials:\n" type
    1                       ( n -- max=n min )
    print_factorials_range  ( max=n min -- )
    s\" \n" type
;

