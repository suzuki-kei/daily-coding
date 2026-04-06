<?php

function main(): void
{
    $array = generate_random_values(20);
    print_array($array);
    insertion_sort($array);
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

function insertion_sort(array &$array): void
{
    for ($end = 1; $end < count($array); $end++)
    {
        $insertion_index = $end;
        $insertion_value = $array[$end];

        while ($insertion_index >= 1 && $insertion_value < $array[$insertion_index - 1])
        {
            $array[$insertion_index] = $array[$insertion_index - 1];
            $insertion_index--;
        }

        $array[$insertion_index] = $insertion_value;
    }
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

