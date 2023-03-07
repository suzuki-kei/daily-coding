
fn main()
{
    for i in 1..10 {
        println!("factorial({}) = {}", i, factorial(i));
    }
}

fn factorial(n: i32) -> i32
{
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)
    }
}

