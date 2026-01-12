require 'my_string'
require 'test/unit'

class MyStringTestCase < Test::Unit::TestCase

    def self.parameterized_test(name, string_expected_map)
        string_expected_map.each_with_index do |(string, expected), index|
            define_method("test_#{name}_#{index + 1}") do
                actual = string.send(name)
                assert_equal expected, actual
            end
        end
    end

    parameterized_test :prefixes, {
        ''    => [''],
        'a'   => ['', 'a'],
        'ab'  => ['', 'a', 'ab'],
        'abc' => ['', 'a', 'ab', 'abc'],
    }

    parameterized_test :proper_prefixes, {
        ''    => [],
        'a'   => [''],
        'ab'  => ['', 'a'],
        'abc' => ['', 'a', 'ab'],
    }

    parameterized_test :suffixes, {
        ''    => [''],
        'a'   => ['', 'a'],
        'ab'  => ['', 'b', 'ab'],
        'abc' => ['', 'c', 'bc', 'abc'],
    }

    parameterized_test :proper_suffixes, {
        ''    => [],
        'a'   => [''],
        'ab'  => ['', 'b'],
        'abc' => ['', 'c', 'bc'],
    }

    parameterized_test :lps, {
        ''          => nil,
        'a'         => '',
        'aa'        => 'a',
        'aaa'       => 'aa',
        'ab'        => '',
        'aba'       => 'a',
        'abab'      => 'ab',
        'ababa'     => 'aba',
        'ababab'    => 'abab',
        'abc'       => '',
        'abca'      => 'a',
        'abcab'     => 'ab',
        'abcabc'    => 'abc',
        'abcabca'   => 'abca',
        'abcabcab'  => 'abcab',
        'abcabcabc' => 'abcabc',
    }

    parameterized_test :lps_array, {
        ''          => [],
        'a'         => [0],
        'aa'        => [0, 1],
        'aaa'       => [0, 1, 2],
        'ab'        => [0, 0],
        'aba'       => [0, 0, 1],
        'abab'      => [0, 0, 1, 2],
        'ababa'     => [0, 0, 1, 2, 3],
        'ababab'    => [0, 0, 1, 2, 3, 4],
        'abc'       => [0, 0, 0],
        'abca'      => [0, 0, 0, 1],
        'abcab'     => [0, 0, 0, 1, 2],
        'abcabc'    => [0, 0, 0, 1, 2, 3],
        'abcabca'   => [0, 0, 0, 1, 2, 3, 4],
        'abcabcab'  => [0, 0, 0, 1, 2, 3, 4, 5],
        'abcabcabc' => [0, 0, 0, 1, 2, 3, 4, 5, 6],
    }

end

