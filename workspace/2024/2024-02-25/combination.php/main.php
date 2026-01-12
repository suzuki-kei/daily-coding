<?php

function main()
{
    demonstration();
}

function demonstration()
{
    foreach (range(0, 6) as $n)
        foreach (range(0, $n) as $r)
            print_combination($n, $r);
}

function print_combination($n, $r)
{
    $c = combination($n, $r);
    echo "C(n={$n}, r={$r}) = {$c}\n";
}

// C(n, r)   = n! / (r! * (n-r)!)
// C(n, r-1) = n! / ((r-1)! * (n-(r-1))!
// r!        = r * (r-1)!
// (n-r)!    = (n-(r-1))! / (n-(r-1))
// C(n, r)   = C(n, r-1) * (n-(r-1)) / r
function combination($n, $r)
{
    if ($n == 0 || $r == 0 || $n == $r)
        return 1;

    return combination($n, $r - 1) * ($n - ($r - 1)) / $r;
}

main();

?>

