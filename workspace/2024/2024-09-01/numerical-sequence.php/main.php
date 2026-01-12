<?php

function main(): void
{
    print_sequence('factorials', 'factorial', 1, 10);
    print_sequence('fibonacci numbers', 'fibonacci', 0, 20);
    print_sequence('fizz buzz values', 'fizz_buzz', 1, 100);
}

function print_sequence(string $description, callable $f, int $min, int $max): void
{
    $values = array_map($f, range($min, $max));
    $string = implode(' ', $values);

    echo "{$description}:\n";
    echo "{$string}\n";
}

function factorial(int $n): int
{
    return factorial_tailrec($n, 1);
}

function factorial_tailrec(int $n, int $accumulated): int
{
    if ($n == 0)
        return $accumulated;
    return factorial_tailrec($n - 1, $accumulated * $n);
}

function fibonacci(int $n): int
{
    return fibonacci_tailrec($n, 0, 1);
}

function fibonacci_tailrec(int $n, int $a, int $b): int
{
    if ($n == 0)
        return $a;
    return fibonacci_tailrec($n - 1, $b, $a + $b);
}

function fizz_buzz(int $n): string
{
    if ($n % 15 == 0)
        return 'FizzBuzz';
    if ($n % 5 == 0)
        return 'Buzz';
    if ($n % 3 == 0)
        return 'Fizz';
    return strval($n);
}

main();

?>

