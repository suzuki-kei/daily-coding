<?php

function main(): void
{
    $array = selection_without_replacement(10, 99, 20);
    print_array($array);
}

function selection_without_replacement(int $min, int $max, int $n): array
{
    $array = [];

    for ($value = $min; $value <= $max; $value++)
    {
        $numerator = $n - count($array);
        $denominator = $max - $value + 1;

        if (random_float() < $numerator / $denominator)
            $array[] = $value;
    }

    return $array;
}

function random_float(): float
{
    return random_int(0, PHP_INT_MAX) / (PHP_INT_MAX + 1.0);
}

function print_array(array $array): void
{
    echo implode(' ', $array), "\n";
}

main();

