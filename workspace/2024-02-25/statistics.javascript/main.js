
function main()
{
    print_deviation_scores(
        [96, 70, 59, 54, 49, 41, 38, 36, 33, 24])
    print_correlation_coefficient(
        [40, 60, 70, 80, 100],
        [50, 60, 30, 70, 90])
    print_feet_to_meter(
        30000)
}

function print_deviation_scores(xs)
{
    console.log("==== 偏差値")

    const deviation_scores_xs = deviation_scores(xs)

    for (let i = 0; i < xs.length; i++)
        console.log(`score=${xs[i]}, deviation_score=${deviation_scores_xs[i]}`)
}

function print_correlation_coefficient(xs, ys)
{
    console.log("==== 相関係数")
    console.log(`xs = ${xs.join(' ')}`)
    console.log(`ys = ${ys.join(' ')}`)
    console.log(`correlation_coefficient = ${correlation_coefficient(xs, ys)}`)
}

function print_feet_to_meter(feet)
{
    console.log("==== フィート -> メートル")
    console.log(`${feet} feet = ${feet_to_meter(feet)} meter`)
}

// 合計
function sum(xs)
{
    return xs.reduce((accumulated, x) => accumulated + x, 0)
}

// 平均
function mean(xs)
{
    return sum(xs) / xs.length
}

// 偏差平方和
function sum_of_squared_deviation(xs, base)
{
    return sum(xs.map(x => Math.pow(x - base, 2)))
}

// 分散
function variance(xs)
{
    return sum_of_squared_deviation(xs, mean(xs)) / xs.length
}

// 不偏分散
function unbiased_variance(xs)
{
    return sum_of_squared_deviation(xs, mean(xs)) / (xs.length - 1)
}

// 標準偏差
function stddev(xs)
{
    return Math.sqrt(variance(xs))
}

// 不偏標準偏差
function unbiased_stddev(xs)
{
    return Math.sqrt(unbiased_variance(xs))
}

// 偏差値
function deviation_score(x, mean, stddev)
{
    return ((x - mean) / stddev) * 10 + 50
}

function deviation_scores(xs)
{
    const mean_xs = mean(xs)
    const stddev_xs = stddev(xs)

    return xs.map(x => deviation_score(x, mean_xs, stddev_xs))
}

// [min, max] の整数配列
function sequence(min, max)
{
    return [...Array(max - min + 1).keys()].map(x => x + min)
}

// 共分散
function covariance(xs, ys)
{
    const mean_xs = mean(xs)
    const mean_ys = mean(ys)

    return mean(sequence(0, xs.length - 1).map(i => (xs[i] - mean_xs) * (ys[i] - mean_ys)))
}

// 相関係数
function correlation_coefficient(xs, ys)
{
    return covariance(xs, ys) / (stddev(xs) * stddev(ys))
}

// フィート -> メートル
function feet_to_meter(feet)
{
    return feet * 0.3048
}

main()

