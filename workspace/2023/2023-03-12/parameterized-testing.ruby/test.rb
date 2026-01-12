require 'test/unit'
require 'parameterized'

def increment(x)
    x + 1
end

def decrement(x)
    x - 1
end

class TestCase < Test::Unit::TestCase

    parameterized :increment, [
        # [expected, x]
        [2, 1],
        [3, 2],
        [4, 3],
        [5, 4],
        [6, 5],
    ]

    parameterized :decrement, [
        [0, 1],
        [1, 2],
        [2, 3],
        [3, 4],
        [4, 5],
    ]

end

