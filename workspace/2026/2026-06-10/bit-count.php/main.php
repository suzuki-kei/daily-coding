<?php

function main(): void
{
    for ($n = 0; $n <= 32; $n++)
        printf("bit_count(%2d) = %d\n", $n, bit_count($n));
}

function bit_count(int $n): int
{
    $n = ($n & 0x55555555) + (($n >>  1) & 0x55555555);
    $n = ($n & 0x33333333) + (($n >>  2) & 0x33333333);
    $n = ($n & 0x0F0F0F0F) + (($n >>  4) & 0x0F0F0F0F);
    $n = ($n & 0x00FF00FF) + (($n >>  8) & 0x00FF00FF);
    $n = ($n & 0x0000FFFF) + (($n >> 16) & 0x0000FFFF);
    return $n;
}

main();

