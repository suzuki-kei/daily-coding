
//
// オブジェクトの型注釈 (type annotation)
//
function example_object_literal()
{
    let box: { width: number, height: number } = { width: 10, height: 20 }

    // 型エイリアスを使ってもよい
    type Box = { width: number, height: number }
    let box2: Box = { width: 10, height: 20 }
}

//
// TypeScript は構造的型付け (structual typing) を採用している.
//
// 名前的型付け (nominal typing):
//     型の互換性の有無を型の名前で決める.
//
// 構造的型付け (structual typing):
//     型の互換性の有無を型の構造で決める.
//     型が持つプロパティやメソッドの構造が同じなら, 名前が異なっても互換性があるとみなす.
//
function example_structual_typing()
{
    class Person {
        walk() { }
    }

    class Dog {
        walk() { }
    }

    const person: Person = new Person()
    const dog: Dog = person
}

//
// 部分型 (subtype)
//
function example_subtype()
{
    class Shape {
        area(): number {
            return 0
        }
    }

    class Circle {
        radius: number

        constructor(radius: number) {
            this.radius = radius
        }

        area(): number {
            return Math.pow(this.radius, 2) * Math.PI
        }
    }

    class Rectangle {
        width: number
        height: number

        constructor(width: number, height: number) {
            this.width = width
            this.height = height
        }

        area(): number {
            return this.width * this.height
        }
    }

    function totalArea(...shapes: Shape[]): number {
        const areas = shapes.map(shape => shape.area())
        return areas.reduce((total, area) => total + area, 0)
    }

    const circle = new Circle(10)
    const rectangle = new Rectangle(3, 5)
    totalArea(circle, rectangle)
}

