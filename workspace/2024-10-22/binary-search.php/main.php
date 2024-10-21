<?php

function main(): void
{
    $values = generate_random_ascending_values(20);
    echo implode(' ', $values), "\n";

    $lower = $values[0] - 1;
    $upper = $values[count($values) - 1] + 1;

    for ($target = $lower; $target <= $upper; $target++)
    {
        $index = binary_search($values, $target);
        echo "target={$target}, index={$index}\n";
    }
}

function generate_random_ascending_values(int $n): array
{
    $value = 9;
    $values = [];

    for ($i = 0; $i < $n; $i++)
    {
        $value += mt_rand(1, 5);
        $values[] = $value;
    }

    return $values;
}

function binary_search(array $values, int $target): int
{
    return binary_search_range($values, $target, 0, count($values) - 1);
}

function binary_search_range(array $values, int $target, int $lower, int $upper): int
{
    if ($lower > $upper)
        return -1;

    $center = intdiv($lower + $upper, 2);

    if ($target == $values[$center])
        return $center;

    if ($target < $values[$center])
        return binary_search_range($values, $target, $lower, $center - 1);
    else
        return binary_search_range($values, $target, $center + 1, $upper);
}

main();

?>

