<?php

declare(strict_types=1);

function main(): void
{
    $values = selectionWithoutReplacement(20, 10, 99);
    echo implode(' ', $values), "\n";

    $min_target = $values[0] - 1;
    $max_target = $values[count($values) - 1] + 1;

    for ($target = $min_target; $target <= $max_target; $target++)
    {
        $index = binarySearch($values, $target);
        printf("target = %d, index = %d\n", $target, $index);
    }
}

function selectionWithoutReplacement(int $n, int $min, int $max): array
{
    $values = [];

    for ($value = $min; $value <= $max; $value++)
    {
        $nRemaining = $n - count($values);
        $nCandidatesRemaining = $max - $value + 1;
        $selectionProbability = $nRemaining / $nCandidatesRemaining;

        if (uniform() < $selectionProbability)
            $values[] = $value;
    }

    return $values;
}

function uniform(): float
{
    return mt_rand() / mt_getrandmax();
}

function binarySearch(array $values, int $target, ?int $first = null, ?int $last = null): int
{
    $first ??= 0;
    $last ??= count($values) - 1;

    if ($first > $last)
        return -1;

    $center = intdiv($first + $last, 2);

    if ($target === $values[$center])
        return $center;

    if ($target < $values[$center])
        return binarySearch($values, $target, $first, $center - 1);
    else
        return binarySearch($values, $target, $center + 1, $last);
}

main();

