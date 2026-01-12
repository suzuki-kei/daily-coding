
: greater
    over over > if
        drop
    else
        swap drop
    endif
;

: maximum recursive ( xn ... x2 x1 size -- maximum_value )
    dup 1 = if
        drop
    else
        rot rot greater
        swap
        1 - maximum
    endif
;

71 40 39 80 25 49 38 79 19 43 .s
10 maximum .s

