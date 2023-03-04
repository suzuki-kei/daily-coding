
fn main()
{
    for x in (0..10).map(fibonacci) {
        println!("{}", x);
    }
}

fn fibonacci(n: i32) -> i32
{
    let mut a = 0;
    let mut b = 1;

    for _ in 0..n {
        b = b + a;
        a = b - a;
    }

    a
}

