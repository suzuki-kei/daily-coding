<?php

function main(): void
{
    $array = range(0, 9);
    print_array($array);
    shuffle_array($array);
    print_array($array);
}

function print_array(array $array): void
{
    echo implode(' ', $array), "\n";
}

function shuffle_array(array &$array): void
{
    for ($i = 0; $i < count($array) - 1; $i++)
    {
        $target = mt_rand($i, count($array) - 1);
        swap($array[$i], $array[$target]);
    }
}

function swap(&$value1, &$value2): void
{
    [$value1, $value2] = [$value2, $value1];
}

main();

