<?php

function main(): void
{
    $array = generate_random_values(20);
    print_array($array);
    shell_sort($array);
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

function shell_sort(array &$array): void
{
    for ($hop = compute_initial_hop(count($array)); 1 <= $hop; $hop = intdiv($hop, 3))
    {
        for ($end = $hop; $end < count($array); $end++)
        {
            $insertion_index = $end;
            $insertion_value = $array[$end];

            while ($insertion_index >= $hop && $insertion_value < $array[$insertion_index - $hop])
            {
                $array[$insertion_index] = $array[$insertion_index - $hop];
                $insertion_index -= $hop;
            }

            $array[$insertion_index] = $insertion_value;
        }
    }
}

function compute_initial_hop(int $n): int
{
    $hop = 1;

    while ($hop * 3 + 1 < $n)
        $hop = $hop * 3 + 1;

    return $hop;
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

