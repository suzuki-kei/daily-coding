import java.util.function.IntFunction;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Main
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

        System.out.format("%s:\n", description);
        System.out.format("%s\n", string);
    }

    private static int factorial(int n)
    {
        if (n == 0)
            return 1;
        return n * factorial(n - 1);
    }

    private static int fibonacci(int n)
    {
        if (n == 0)
            return 0;
        if (n == 1)
            return 1;
        return fibonacci(n - 1) + fibonacci(n - 2);
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

