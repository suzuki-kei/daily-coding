<?php

function main()
{
    $values = generate_random_ascending_values(20);
    echo implode(' ', $values), "\n";

    $lower = reset($values) - 1;
    $upper = end($values) + 1;

    foreach (range($lower, $upper) as $target)
    {
        $index = binary_search($values, $target);
        echo "target={$target}, index={$index}\n";
    }
}

function generate_random_ascending_values($n)
{
    $value = 9;
    $values = [];

    for ($i = 0; $i < $n; $i++)
    {
        $value += rand(1, 5);
        $values[] = $value;
    }
    return $values;
}

function binary_search($values, $target)
{
    return binary_search_range($values, $target, 0, count($values) - 1);
}

function binary_search_range($values, $target, $lower, $upper)
{
    if ($lower > $upper)
        return -1;

    $center = intdiv($lower + $upper, 2);

    if ($target < $values[$center])
        return binary_search_range($values, $target, $lower, $center - 1);
    if ($target > $values[$center])
        return binary_search_range($values, $target, $center + 1, $upper);
    return $center;
}

main();

?>

