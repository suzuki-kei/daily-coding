
function main()
{
//    console.log("==== example_callback_hell")
//    example_callback_hell()
//
//    console.log("==== example_promise")
//    example_promise()
//
//    console.log("==== example_async_await")
//    example_async_await()
}

function example_callback_hell() {
    function f1(success, failure) {
        if (Math.random() < 0.8) {
            success()
        } else {
            failure()
        }
    }
    function f2(success, failure) {
        if (Math.random() < 0.8) {
            success()
        } else {
            failure()
        }
    }
    function f3(success, failure) {
        if (Math.random() < 0.8) {
            success()
        } else {
            failure()
        }
    }

    f1(function(v1) {
        console.log("f1 success")
        f2(function(v2) {
            console.log("f2 success")
            f3(function(v3) {
                console.log("f3 success")
            }, function() {
                console.log("f3 failed")
            })
        }, function() {
            console.log("f2 failed")
        })
    }, function() {
        console.log("f1 failed")
    })
}

function example_promise()
{
    function f1() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve()
            } else {
                reject("f1 failed")
            }
        })
    }
    function f2() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve()
            } else {
                reject("f2 failed")
            }
        })
    }
    function f3() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve()
            } else {
                reject("f3 failed")
            }
        })
    }

    f1().then(() => f2())
        .then(() => f3())
        .then(() => console.log("f3 success"))
        .catch(message => console.log(message))
}

function example_async_await()
{
    function f1() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve("f1 success")
            } else {
                reject("f1 failed")
            }
        })
    }
    function f2() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve("f2 success")
            } else {
                reject("f2 failed")
            }
        })
    }
    function f3() {
        return new Promise((resolve, reject) => {
            if (Math.random() < 0.8) {
                resolve("f3 success")
            } else {
                reject("f3 failed")
            }
        })
    }

    async function execute() {
        console.log(await f1())
        console.log(await f2())
        console.log(await f3())
    }

    execute().catch(message => console.log(message))
}

main()

