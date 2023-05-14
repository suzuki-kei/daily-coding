
fn main()
{
    show_numerical_sequence("factorials", factorial, 1, 10);
    show_numerical_sequence("fibonacci numbers", fibonacci, 0, 20);
    show_numerical_sequence("FizzBuzz values", fizzbuzz, 1, 100);
}

fn show_numerical_sequence<T: std::fmt::Display>(
    description: &str, f: fn(i32) -> T, min: i32, max: i32)
{
    let values = (min..=max).map(f);
    let string_values = values.map(|x| x.to_string()).collect::<Vec<String>>();

    println!("{}:", description);
    println!("{}", string_values.join(" "));
}

fn factorial(n: i32) -> i32
{
    match n {
        0 => 1,
        _ => n * factorial(n - 1),
    }
}

fn fibonacci(n: i32) -> i32
{
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn fizzbuzz(n: i32) -> String
{
    match (n % 5, n % 3) {
        (0, 0) => "FizzBuzz".to_string(),
        (0, _) => "Buzz".to_string(),
        (_, 0) => "Fizz".to_string(),
        (_, _) => n.to_string(),
    }
}

