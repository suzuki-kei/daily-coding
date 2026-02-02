require 'test/unit'
require 'permutations'

class PermutationsTestCase < Test::Unit::TestCase

    def test_permutations
        argument_expected_pairs = {
            [] => [
            ],
            [1] => [
                [1],
            ],
            [1, 2] => [
                [1, 2],
                [2, 1],
            ],
            [1, 2, 3] => [
                [1, 2, 3],
                [1, 3, 2],
                [2, 1, 3],
                [2, 3, 1],
                [3, 1, 2],
                [3, 2, 1],
            ],
        }

        argument_expected_pairs.each do |argument, expected|
            assert_equal expected.sort, permutations(argument).sort
        end
    end

end

