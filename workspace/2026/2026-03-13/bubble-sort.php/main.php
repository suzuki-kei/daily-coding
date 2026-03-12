<?php

function main(): void
{
    $array = generate_random_values(20);
    print_array($array);
    bubble_sort($array);
    print_array($array);
}

function generate_random_values(int $n): array
{
    return array_map(
        fn($_) => mt_rand(10, 99),
        range(1, $n));
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

function bubble_sort(array &$array): void
{
    for ($end = count($array); $end > 0; $end--)
        for ($i = 0; $i < $end - 1; $i++)
            if ($array[$i] > $array[$i + 1])
                swap($array, $i, $i + 1);
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

