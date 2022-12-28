# Run-Length Encoding

## Words

xs
    値のリスト.
    Ex. '(a a b c c c)

run
    同じ値からなるリスト.
    Ex. '(a a)

runs
    run のリスト.
    Ex. '((a a) (b) (c c c))

encoded-run
    エンコードされた run.
    Ex. '(a . 2)

encoded-runs
    encoded-run のリスト.
    Ex. '((a . 2) (b . 1) (c . 3))

## Procedures

encode xs => encoded-runs
    値のリストを Run-Length Encoding でエンコードする.
    Ex. '(a a b c c c) => '((a . 2) (b . 1) (c . 3))

xs->encoded-runs xs => encoded-runs
    xs を encoded-runs に変換する.
    Ex. '(a a b c c c) => '((a . 2) (b . 1) (c . 3))

run->encoded-run run => encoded-run
    run を encoded-run に変換する.
    Ex. '(a a) => '(a . 2)

xs->runs xs => runs
    xs を runs に変換する.
    Ex. '(a a b c c c) => '((a a) (b) (c c c))

decode encoded-runs => xs
    Run-Length Encoding でエンコードされたリストをデコードする.
    Ex. '((a . 2) (b . 1) (c . 3)) => '(a a b c c c)

encoded-runs->xs encoded-runs => xs
    encoded-runs を xs に変換する.
    Ex. '((a . 2) (b . 1) (c . 3)) => '(a a b c c c)

encoded-run->run encoded-run => run
    encoded-run を run に変換する.
    Ex. '(a . 2) => '(a a)

runs->xs runs => xs
    runs を xs に変換する.
    Ex. '((a a) (b) (c c c)) => '(a a b c c c)

