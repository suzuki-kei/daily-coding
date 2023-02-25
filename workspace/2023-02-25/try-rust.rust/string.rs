
fn main()
{
    let mut s = String::from("Hello");
    s.push_str(", World!");
    println!("{}", s);

    let s1 = String::from("Hello, World!");
    let s2 = s1;
    println!("{}", s2);

    let mut s = String::new();
    set_hello_world(&mut s);
    println!("{}", s);

    let s = "Hello, World!";
    let s1 = &s[0..=4];
    let s2 = &s[7..=11];
    println!("{}, {}!", s1, s2);
}

fn set_hello_world(s: &mut String)
{
    s.push_str("Hello, World!");
}

