
class User {

    id: number
    name: string
    age: number

    constructor(name: string, age: number) {
        this.name = name
        this.age = age
    }

    clone(): User {
        return {...this}
    }

}

interface UserRepository {
    all(): Array<User>
    find(id: number): User
    create(user: User): void
    update(user: User): void
    delete(user: User): void
}

class OnMemoryUserRepository implements UserRepository {

    private database: {[key: number]: User}
    private sequence: number

    constructor() {
        this.database = []
        this.sequence = 1
    }

    all(): Array<User> {
        var users: Array<User> = []

        for (var key in this.database) {
            users.push(this.database[key])
        }
        return users
    }

    find(id: number): User {
        if (!(id in this.database))
            throw NotFoundError

        return this.database[id]
    }

    create(user: User): void {
        if (user.id in this.database)
            throw DuplicationError

        user.id = this.generateId()
        this.database[user.id] = user.clone()
    }

    update(user: User): void {
        if (!(user.id in this.database))
            throw NotFoundError

        this.database[user.id] = user.clone()
    }

    delete(user: User): void {
        if (!(user.id in this.database))
            throw NotFoundError

        delete this.database[user.id]
    }

    private generateId(): number {
        return this.sequence++
    }

}

class NotFoundError extends Error { }
class DuplicationError extends Error { }

const userRepository = new OnMemoryUserRepository()
userRepository.create(new User("taro", 10))
userRepository.create(new User("jiro", 11))
userRepository.create(new User("hanako", 12))

for (const user of userRepository.all()) {
    console.log(user)
}

