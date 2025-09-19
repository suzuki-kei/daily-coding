use strict;
use warnings;

sub main
{
    print_sequence('factorials', \&factorial, 1, 10);
    print_sequence('fibonacci numbers', \&fibonacci, 0, 20);
    print_sequence('fizz buzz values', \&fizz_buzz, 1, 100);
}

sub print_sequence
{
    my ($label, $f, $min, $max) = @_;
    my @values = map { $f->($_) } $min..$max;
    my $formatted = join(' ', @values);

    print "${label}:\n";
    print "${formatted}\n";
}

sub factorial
{
    my ($n, $fm) = @_;
    $fm //= 1;

    return $fm if $n == 0;
    return factorial($n - 1, $fm * $n);
}

sub fibonacci
{
    my ($n, $a, $b) = @_;
    $a //= 0;
    $b //= 1;

    return $a if $n == 0;
    return fibonacci($n - 1, $b, $a + $b);
}

sub fizz_buzz
{
    my ($n) = @_;
    return 'FizzBuzz' if $n % 15 == 0;
    return 'Buzz' if $n % 5 == 0;
    return 'Fizz' if $n % 3 == 0;
    return "$n";
}

main();

