
fn main()
{
    let x: Option<i32> = Some(123);
    println!("x = {:?}", x);
    x.map(|x| println!("x = {}", x));

    let x: Option<i32> = None;
    println!("x = {:?}", x);
    x.map(|x| println!("x = {}", x));
}

