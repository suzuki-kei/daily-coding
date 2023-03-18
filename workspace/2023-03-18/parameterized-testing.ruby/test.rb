require 'test/unit'
require 'parameterized'

def add(a, b)
    a + b
end

def increment(x)
    x + 1
end

def decrement(x)
    x - 1
end

class TestCase < Test::Unit::TestCase

    parameterized :add, {
        [1, 2] => 3,
        [3, 4] => 7,
        [5, 6] => 11,
        [7, 8] => 15,
    }

    parameterized :increment, {
        1 => 2,
        2 => 3,
        3 => 4,
        4 => 5,
        5 => 6,
    }

    parameterized :decrement, {
        1 => 0,
        2 => 1,
        3 => 2,
        4 => 3,
        5 => 4,
    }

end

