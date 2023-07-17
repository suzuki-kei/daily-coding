
fn main()
{
    print_sequence("factorials", factorial, 1, 10);
    print_sequence("fibonacci numbers", fibonacci, 0, 20);
    print_sequence("fizz buzz values", fizz_buzz, 1, 100);
}

fn print_sequence<T>(description: &str, f: fn(i32) -> T, min: i32, max: i32)
    where T: std::fmt::Display
{
    let values = (min..=max).map(|x| f(x).to_string()).collect::<Vec<String>>();

    println!("{}:", description);
    println!("{}", values.join(" "));
}

fn factorial(n: i32) -> i32
{
    match n
    {
        0 => 1,
        _ => n * factorial(n - 1),
    }
}

fn fibonacci(n: i32) -> i32
{
    match n
    {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn fizz_buzz(n: i32) -> String
{
    match (n % 5, n % 3)
    {
        (0, 0) => "FizzBuzz".to_string(),
        (0, _) => "Buzz".to_string(),
        (_, 0) => "Fizz".to_string(),
        (_, _) => n.to_string(),
    }
}

