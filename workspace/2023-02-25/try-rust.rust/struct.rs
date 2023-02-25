
fn main()
{
    let rectangle = Rectangle {
        width: 10,
        height: 20,
    };
    println!("{:?}", rectangle);
    println!("area={}", rectangle.area());

    let rectangle = Rectangle::square(100);
    println!("{:?}", rectangle);
}

#[derive(Debug)]
struct Rectangle
{
    width: u32,
    height: u32,
}

impl Rectangle
{
    fn square(size: u32) -> Rectangle
    {
        Rectangle {
            width: size,
            height: size,
        }
    }

    fn area(&self) -> u32
    {
        self.width * self.height
    }
}

