<?php

function main()
{
    $array = range(0, 9);
    print_array($array);
    shuffle_array($array);
    print_array($array);
}

function print_array(array $array)
{
    echo implode(' ', $array) . "\n";
}

function shuffle_array(array &$array)
{
    for ($i = 0; $i < count($array) - 1; $i++)
    {
        $target = random_int($i, count($array) - 1);
        [$array[$i], $array[$target]] = [$array[$target], $array[$i]];
    }
}

main();

