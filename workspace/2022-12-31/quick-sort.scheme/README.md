# quick-sort.scm

## Procedures

    generate-random-values n
        n 個の整数の乱数を生成します.

    sorted? xs
        整数のリストが昇順に整列されているか判定します.

    quick-sort xs => xs
        数のリストをクイックソートで整列します.

    partition pivot xs => (values less-xs equal-xs greater-xs)
        数のリストを pivot を基準に 3 分割し, 多値を返します.

