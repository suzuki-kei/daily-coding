
def mean(values):
    """算術平均"""
    return sum(values) / len(values)


def median(values):
    """中央値"""
    sorted_values = sorted(values)

    if len(sorted_values) % 2 == 0:
        a = sorted_values[len(sorted_values) // 2]
        b = sorted_values[len(sorted_values) // 2 - 1]
        return (a + b) / 2
    else:
        return sorted_values[len(sorted_values) // 2]


def mode(values):
    """最頻値"""
    to_key = lambda key_value: key_value[-1]
    return max(histogram(values).items(), key=to_key)[0]


def histogram(values):
    """ヒストグラム"""
    def increment(map, key):
        map[key] = map.get(key, 0) + 1
        return map

    return reduce(increment, values, {})


def reduce(reducer, values, initial=None):
    if initial is None:
        reduced = values[0]
        values = values[1:]
    else:
        reduced = initial

    for value in values:
        reduced = reducer(reduced, value)
    return reduced

