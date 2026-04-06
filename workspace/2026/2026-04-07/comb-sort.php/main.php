<?php

function main(): void
{
    $array = generate_random_values(20);
    print_array($array);
    comb_sort($array);
    print_array($array);
}

function generate_random_values(int $n): array
{
    $random = fn($_) => mt_rand(10, 99);
    return array_map($random, range(1, $n));
}

function print_array(array $array): void
{
    if (is_sorted($array))
        echo implode(' ', $array), " (sorted)\n";
    else
        echo implode(' ', $array), " (not sorted)\n";
}

function is_sorted(array $array): bool
{
    for ($i = 0; $i < count($array) - 1; $i++)
        if ($array[$i] > $array[$i + 1])
            return false;

    return true;
}

function comb_sort(array &$array): void
{
    $gap = count($array);
    $done = false;

    while ($gap > 1 || !$done)
    {
        $gap = compute_next_gap($gap);
        $done = true;

        for ($i = 0; $i + $gap < count($array); $i += $gap)
        {
            if ($array[$i] > $array[$i + $gap])
            {
                swap($array, $i, $i + $gap);
                $done = false;
            }
        }
    }
}

function compute_next_gap(int $gap): int
{
    if ($gap <= 2)
        return 1;

    if ($gap == 9 || $gap == 10)
        return 11;

    return intdiv($gap * 10, 13);
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

