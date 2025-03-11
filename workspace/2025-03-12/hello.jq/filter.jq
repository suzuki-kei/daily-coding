
.data as $data
    | $data | map(.count) | add as $total
    | $data | map({hour: .hour, count: .count, ratio: (.count / $total)})

