[
    () => {
        type User = {
            firstName: string,
            lastName: string,
            age: number,
            favoriteFoods: string[],
            hasProgrammingExperience: boolean,
        }
        const user: User = {
            firstName: "太郎",
            lastName: "佐藤",
            age: 24,
            favoriteFoods: ["寿司", "ラーメン", "カレー"],
            hasProgrammingExperience: true,
        }
        function getSelfIntroduction(user: User): string {
            const lines: string[] = [
                `私の名前は${user.lastName}${user.firstName}です。`,
                `年齢は${user.age}歳です。`,
                `好きな食べ物は${user.favoriteFoods.join("と")}です。`,
                `プログラミング経験は${user.hasProgrammingExperience ? "あります" : "ありません"}。`,
            ]
            return lines.join("\n")
        }
        function identity<T>(x: T): T {
            return x
        }
        type Subject = { kind: "name", payload: string }
                     | { kind: "favorite_food", payload: string[] }

        function printSelfIntroduction(subject: Subject): void {
            switch (subject.kind) {
                case "name":
                    console.log(`私の名前は${subject.payload}です`)
                    break
                case "favorite_food":
                    console.log(`私の好きな食べ物は${subject.payload.join("と")}です`)
                    break
                default:
                    identity<never>(subject)
            }
        }
        console.log(getSelfIntroduction(user))
        printSelfIntroduction({ kind: "name", payload: `${user.lastName}${user.firstName}` })
        printSelfIntroduction({ kind: "favorite_food", payload: user.favoriteFoods })
    },
    () => {
        function triple<T>(x: T): [T, T, T] {
            return [x, x, x]
        }
        console.log(triple(123))
        console.log(triple("hello"))
    },
    () => {
        function myArrayMap<T, U>(xs: T[], f: (x: T) => U): U[] {
            const ys: U[] = []

            for (let i = 0; i < xs.length; i++)
                ys.push(f(xs[i]))

            return ys
        }
        console.log(myArrayMap([0, 1, 2, 3, 4], n => n % 2 === 0))
        console.log(myArrayMap([123, true, "text"], x => x.toString()))
    },
].forEach(f => f())

