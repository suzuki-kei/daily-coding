require 'test/unit'
require 'parameterized'

def add(a, b)
    a + b
end

class TestCase < Test::Unit::TestCase

    parameterized :add, {
        [1, 2] => 3,
        [3, 4] => 7,
        [5, 6] => 11,
        [7, 8] => 15,
    }

end

