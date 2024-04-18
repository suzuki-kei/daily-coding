
function main()
{
    //example_callback_hell()
    //example_promise()
    example_async_await()
}

function example_callback_hell()
{
    function f1(resolve, reject) {
        if (Math.random() < 0.8) {
            resolve(`f1: success`)
        } else {
            reject(`f1: failed`)
        }
    }
    function f2(resolve, reject) {
        if (Math.random() < 0.8) {
            resolve(`f2: success`)
        } else {
            reject(`f2: failed`)
        }
    }
    function f3(resolve, reject) {
        if (Math.random() < 0.8) {
            resolve(`f3: success`)
        } else {
            reject(`f3: failed`)
        }
    }

    f1(_ => {
        f2(_ => {
            f3(message => {
                console.log(message)
            },
            message => {
                console.log(message)
            })
        },
        message => {
            console.log(message)
        })
    },
    message => {
        console.log(message)
    })
}

function example_promise()
{
    function newPromise(name) {
        return  new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve(`${name}: success`)
            } else {
                reject(`${name}: failed`)
            }
        })
    }

    newPromise("f1")
        .then(() => newPromise("f2"))
        .then(() => newPromise("f3"))
        .then(() => console.log("success"))
        .catch(message => console.log(message))
}

function example_async_await()
{
    function newPromise(name) {
        return  new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve(`${name}: success`)
            } else {
                reject(`${name}: failed`)
            }
        })
    }

    async function execute() {
        const p1 = await newPromise("f1")
        const p2 = await newPromise("f2")
        const p3 = await newPromise("f3")
    }

    execute()
        .then(() => console.log("success"))
        .catch(message => console.log(message))
}

main()

