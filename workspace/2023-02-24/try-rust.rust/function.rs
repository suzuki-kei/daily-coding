
fn main()
{
    let n = 10;
    println!("increment({}) = {}", n, increment(n));

    let n = 10;
    println!("decrement({}) = {}", n, decrement(n));

    let n = 10;
    println!("fibonacci_loop({}) = {}", n, fibonacci_loop(n));
    println!("fibonacci_recursive({}) = {}", n, fibonacci_recursive(n));

    let n = 5;
    println!("factorial_loop({}) = {}", n, factorial_loop(n));
    println!("factorial_recursive({}) = {}", n, factorial_recursive(n));
}

fn increment(x: i32) -> i32
{
    return x + 1;
}

fn decrement(x: i32) -> i32
{
    // 関数の最後の式が戻り値となるので return を書かなくても良い.
    x - 1
}

fn fibonacci_loop(n: i32) -> i32
{
    let mut a = 0;
    let mut b = 1;

    for _ in 0..n {
        b = a + b;
        a = b - a;
    }

    a
}

fn fibonacci_recursive(n: i32) -> i32
{
    if n <= 1 {
        return n;
    }
    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2);
}

fn factorial_loop(n: i32) -> i32
{
    let mut result = 1;

    for i in 1..=n {
        result *= i;
    }
    return result;
}

fn factorial_recursive(n: i32) -> i32
{
    if n == 1 {
        return 1;
    }
    return n * factorial_recursive(n - 1);
}

