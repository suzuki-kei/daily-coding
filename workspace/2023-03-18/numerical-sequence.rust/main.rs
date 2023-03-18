
fn main()
{
    println!("factorial:");
    print_values(&(1..=10).map(factorial).collect());
    println!();

    println!("fibonacci:");
    print_values(&(1..=20).map(fibonacci).collect());
    println!();

    println!("FizzBuzz:");
    print_values(&(1..=100).map(fizz_buzz).collect());
    println!();
}

fn print_values<T: std::fmt::Display>(values: &Vec<T>)
{
    for x in values {
        print!("{} ", x);
    }
    println!();
}

fn factorial(n: i32) -> i32
{
    match n {
        0 => 1,
        _ => n * factorial(n - 1)
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

fn fizz_buzz(n: i32) -> String
{
    if n % 15 == 0 {
        "FizzBuzz".to_string()
    } else if n % 5 == 0 {
        "Buzz".to_string()
    } else if n % 3 == 0 {
        "Fizz".to_string()
    } else {
        n.to_string()
    }
}

