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
    my ($description, $f, $min, $max) = @_;
    my @values = map { $f->($_) } $min..$max;
    my $string = join ' ', @values;

    print "${description}:\n";
    print "${string}\n";
}

sub factorial
{
    my $n = shift;

    return factorial_tailrec($n, 1);
}

sub factorial_tailrec
{
    my ($n, $accumulated) = @_;

    if ($n == 0) {
        return $accumulated;
    }
    return factorial_tailrec($n - 1, $accumulated * $n);
}

sub fibonacci
{
    my $n = shift;

    return fibonacci_tailrec($n, 0, 1);
}

sub fibonacci_tailrec
{
    my ($n, $a, $b) = @_;

    if ($n == 0) {
        return $a;
    }
    return fibonacci_tailrec($n - 1, $b, $a + $b);
}

sub fizz_buzz
{
    my $n = shift;

    if ($n % 15 == 0) {
        return 'FizzBuzz';
    }
    if ($n % 5 == 0) {
        return 'Buzz';
    }
    if ($n % 3 == 0) {
        return 'Fizz';
    }
    return $n;
}

main;

