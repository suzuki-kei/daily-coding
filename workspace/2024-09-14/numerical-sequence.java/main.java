import java.util.function.IntFunction;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

class Main
{

    public static void main(String[] arguments)
    {
        printSequence("factorials", Main::factorial, 1, 10);
        printSequence("fibonacci numbers", Main::fibonacci, 0, 20);
        printSequence("fizz buzz values", Main::fizzBuzz, 1, 100);
    }

    private static <T> void printSequence(String description, IntFunction<T> f, int min, int max)
    {
        Stream<T> values = IntStream.rangeClosed(min, max).mapToObj(f);
        String string = values.map(String::valueOf).collect(Collectors.joining(" "));

        System.out.printf("%s:\n%s\n", description, string);
    }

    private static int factorial(int n)
    {
        return factorial(n, 1);
    }

    private static int factorial(int n, int accumulated)
    {
        if (n == 0)
            return accumulated;
        return factorial(n - 1, accumulated * n);
    }

    private static int fibonacci(int n)
    {
        return fibonacci(n, 0, 1);
    }

    private static int fibonacci(int n, int a, int b)
    {
        if (n == 0)
            return a;
        return fibonacci(n - 1, b, a + b);
    }

    private static String fizzBuzz(int n)
    {
        if (n % 15 == 0)
            return "FizzBuzz";
        if (n % 5 == 0)
            return "Buzz";
        if (n % 3 == 0)
            return "Fizz";
        return String.valueOf(n);
    }

}

