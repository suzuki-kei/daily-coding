
: print_sierpinski_gasket_row ( height width y x -- height width y )
    2 pick over = if
        s\" \n" type
        drop            ( height width y x -- height width y )
    else
        over over and   ( height width y x -- height width y x y&x )
        0 = if
            s" ＊" type
        else
            s" 　" type
        endif
        1 +             ( height width y x -- height width y x+1 )
        recurse
    endif
;

: print_sierpinski_gasket_rows ( height width y -- )
    2 pick over = if
        drop drop drop              ( height width y -- )
    else
        0                           ( height width y -- height width y x )
        print_sierpinski_gasket_row ( height width y x -- height width y )
        1 +                         ( height width y -- height width y+1 )
        recurse
    endif
;

: print_sierpinski_gasket ( height width -- )
    0                               ( height width -- height width y )
    print_sierpinski_gasket_rows    ( height width y -- )
;

: main ( -- )
    32 32                   ( -- height width )
    print_sierpinski_gasket ( height width -- )
    bye
;

