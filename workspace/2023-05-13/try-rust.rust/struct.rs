
fn main() {
    let rectangles = [
        Rectangle {
            point: Point { x: 100, y: 100 },
            size: Size { width: 10, height: 20 },
        },
        Rectangle {
            point: Point { x: 100, y: 100 },
            size: Size { width: 11, height: 20 },
        },
        Rectangle {
            point: Point { x: 100, y: 100 },
            size: Size { width: 10, height: 21 },
        },
    ];

    for i in 0..rectangles.len() {
        println!("rectangles[{}] = {:?}", i, rectangles[i]);
        println!("rectangles[{}].area = {:?}", i, rectangles[i].area());
    }
    println!();

    for i in 0..rectangles.len() {
        println!("rectangles[0].contains(rectangles[{}]) = {}", i, rectangles[0].contains(&rectangles[i]));
    }
}

#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

#[derive(Debug)]
struct Size {
    width: i32,
    height: i32,
}

#[derive(Debug)]
struct Rectangle {
    point: Point,
    size: Size,
}

impl Rectangle {

    fn area(&self) -> i32 {
        self.size.width * self.size.height
    }

    fn left(&self) -> i32 {
        self.point.x
    }

    fn right(&self) -> i32 {
        self.point.x + self.size.width - 1
    }

    fn top(&self) -> i32 {
        self.point.y
    }

    fn bottom(&self) -> i32 {
        self.point.y + self.size.height - 1
    }

    fn contains(&self, rectangle: &Rectangle) -> bool {
        self.left() <= rectangle.left() && rectangle.right() <= self.right() &&
        self.top() <= rectangle.top() && rectangle.bottom() <= self.bottom()
    }

}

