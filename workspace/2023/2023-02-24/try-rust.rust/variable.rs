
fn main()
{
    println!("==== 変数を使う");
    {
        let s = "hello";
        println!("s = {}", s);
    }

    println!("==== デフォルトで immutable");
    {
        let x = 100;
        println!("x = {}", x);

        // 再代入するとエラーになる.
        // x = 777;

        // mut を指定した変数は mutable.
        let mut y = 100;
        println!("y = {}", y);
        y = 200;
        println!("y = {}", y);
    }

    println!("==== シャドーイング");
    {
        let x = 123;
        println!("x = {}", x);

        let x = x * 2;
        println!("x = {}", x);

        let x = "hello";
        println!("x = {}", x);
    }

    println!("==== データ型");
    {
        // 32-bit signed integer.
        let i32_value: i32 = 123;
        println!("i32_value = {}", i32_value);

        // 64-bit floating point number.
        let f64_value: f64 = 123.456;
        println!("f64_value = {}", f64_value);

        // bool
        let bool_value: bool = true;
        println!("bool_value = {}", bool_value);

        // char
        let char_value: char = 'A';
        println!("char_value = {}", char_value);

        // 文字列
        let str_ref_value: &str = "hello";
        println!("str_ref_value = {}", str_ref_value);

        // タプル
        let tuple_value: (i32, i32, i32) = (1, 2, 3);
        println!("tuple_value = ({}, {}, {})", tuple_value.0, tuple_value.1, tuple_value.2);
        // タプルの要素はパターンマッチで分解できる.
        let (a, b, c) = tuple_value;
        println!("tuple_value = ({}, {}, {})", a, b, c);

        // 配列
        let array: [i32; 3] = [1, 2, 3];
        println!("array = [{}, {}, {}]", array[0], array[1], array[2]);
    }

    println!("==== 四則演算");
    {
        let a = 1;
        let b = 2;
        println!("{} + {} = {}", a, b, a + b);

        let a = 5;
        let b = 3;
        println!("{} - {} = {}", a, b, a - b);

        let a = 2;
        let b = 3;
        println!("{} * {} = {}", a, b, a * b);

        let a = 2;
        let b = 3;
        println!("{} / {} = {}", a, b, a / b);

        let a = 2.0;
        let b = 3.0;
        println!("{} / {} = {}", a, b, a / b);

        let a = 7;
        let b = 3;
        println!("{} % {} = {}", a, b, a % b);
    }
}

