.data as $m
    | $m | map(.count) | add as $total
    | $m | map({hour: .hour, count: .count, ratio: (.count / $total)})

