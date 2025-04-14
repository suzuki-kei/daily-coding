
.data as $data
    | $data | map(.requests) | add as $total
    | $data | map({hour: .hour, requests: .requests, ratio: (.requests / $total)})

