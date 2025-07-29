
type MyPick<T, Keys extends keyof T> = {
    [key in Keys]: T[key]
}

type User = {
    name: string,
    email: string,
    deleted: boolean,
}

type UserView = MyPick<User, "name" | "email">

function main(): void
{
    const user: User = {
        name: "taro",
        email: "taro@example.com",
        deleted: false,
    }
    console.log(user)

    const userView: UserView = {
        user.name,
        user.email,
    }
    console.log(userView)
}

main()

