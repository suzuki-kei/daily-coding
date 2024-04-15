
//
// const アサーション (const assertion)
//
// 変数を const 宣言しても mutable 型のプロパティは変更可能.
// リテラルの末尾に "as const" を付けることでプロパティが読み取り専用になる.
//
function example_const_assertion()
{
    const xs = [1, 2, 3]
    xs.push(4)  // OK

    const ys = [1, 2, 3] as const
    ys.push(4)  // NG
}

//
// 型推論 (type inference)
//
function example_type_inference()
{
    let x = 123
    x = 456      // OK
    x = "hello"  // NG
}

//
// リテラル型 (literal type)
//
function example_literal_type()
{
    let x1: number = 1     // 通常の型指定
    let x2: 1 | 2 | 3 = 3  // OK
    let x3: 1 | 2 | 3 = 4  // NG
}

function example_never(x: 1 | 2 | 3)
{
    // default 節で x を never 型の変数に代入することで,
    // case で x の全パターンを網羅し忘れた場合にコンパイルエラーになる.
    {
        switch(x)
        {
            case 1:
                break
            case 2:
                break
            default:
                const _: never = x
        }
    }

    // 全パターンを網羅していればコンパイルエラーにならない.
    {
        switch(x)
        {
            case 1:
                break
            case 2:
                break
            case 3:
                break
            default:
                const _: never = x
        }
    }

    // 分かりやすい名前の関数を定義しておき, それを呼び出しても良い.
    {
        class SwitchStatementExhaustivenessViolationError extends Error
        {
        }

        function assert_exhaustiveness(_: never)
        {
            // 空実装より例外を投げておいた方がコンパイル後のコードが理解しやすい.
            throw new SwitchStatementExhaustivenessViolationError()
        }

        switch(x)
        {
            case 1:
                break
            case 2:
                break
            default:
                assert_exhaustiveness(x)
        }
    }
}

