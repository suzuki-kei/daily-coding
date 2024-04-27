require 'parameterized'
require 'test/unit'

def add(x, y)
    x + y
end

class TestCase < Test::Unit::TestCase

    parameterized :add, {
        [1, 2] => 3,
        [3, 4] => 7,
        [5, 6] => 11,
        [7, 8] => 15,
    }

end

