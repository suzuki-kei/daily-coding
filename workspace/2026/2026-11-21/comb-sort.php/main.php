<?php

function main(): void
{
    $array = generate_random_values(20, 10, 99);
    print_array($array);
    comb_sort($array);
    print_array($array);
}

function generate_random_values(int $n, int $min, int $max): array
{
    return array_map(
        fn() => mt_rand($min, $max),
        sequence(0, $n));
}

function print_array(array $array): void
{
    if (is_sorted($array))
        printf("%s (sorted)\n", implode(' ', $array));
    else
        printf("%s (not sorted)\n", implode(' ', $array));
}

function is_sorted(array $array): bool
{
    return array_all(
        sequence(0, count($array) - 1),
        fn($i) => $array[$i] <= $array[$i + 1]);
}

function sequence(int $begin, int $end): array
{
    if ($begin >= $end)
        return [];

    return range($begin, $end - 1);
}

function comb_sort(array &$array): void
{
    $gap = count($array);
    $swapped = false;

    do
    {
        $gap = to_next_gap($gap);
        $swapped = false;

        for ($i = 0; $i + $gap < count($array); $i++)
        {
            if ($array[$i] > $array[$i + $gap])
            {
                swap($array[$i], $array[$i + $gap]);
                $swapped = true;
            }
        }
    }
    while (1 < $gap || $swapped);
}

function to_next_gap(int $gap): int
{
    if ($gap <= 2)
        return 1;

    if (13 <= $gap && $gap <= 15)
        return 11;

    return (int) ($gap / 1.3);
}

function swap(mixed &$value1, mixed &$value2): void
{
    [$value1, $value2] = [$value2, $value1];
}

main();

