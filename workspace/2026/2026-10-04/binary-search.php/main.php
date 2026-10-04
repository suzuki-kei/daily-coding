<?php

declare(strict_types=1);

function main(): void
{
    $array = selection_without_replacement(10, 99, 20);
    echo implode(' ', $array), "\n";

    $min_target = $array[0] - 1;
    $max_target = $array[count($array) - 1] + 1;

    for ($target = $min_target; $target <= $max_target; $target++)
    {
        $index = binary_search($array, $target);
        echo "target = {$target}, index = {$index}\n";
    }
}

function selection_without_replacement(int $min, int $max, int $n): array
{
    $array = [];

    for ($i = $min; $i <= $max; $i++)
    {
        $n_remaining = $n - count($array);
        $n_candidates_remaining = $max - $i + 1;
        $selection_probability = $n_remaining / $n_candidates_remaining;

        if (uniform() < $selection_probability)
            $array[] = $i;
    }

    return $array;
}

function uniform(): float
{
    return mt_rand() / mt_getrandmax();
}

function binary_search(array $array, int $target, ?int $begin = null, ?int $end = null): int
{
    $begin ??= 0;
    $end ??= count($array) - 1;

    if ($begin >= $end)
        return -1;

    $center = intdiv($begin + $end, 2);

    if ($target === $array[$center])
        return $center;

    if ($target < $array[$center])
        return binary_search($array, $target, $begin, $center - 1);
    else
        return binary_search($array, $target, $center + 1, $end);
}

main();

