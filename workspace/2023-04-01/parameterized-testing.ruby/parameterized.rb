
def parameterized(name, arguments_expected_map)
    arguments_expected_map.each_with_index do |(arguments, expected), index|
        define_method("test_#{name}_#{index + 1}") do
            actual = method(name).call(*arguments)
            assert_equal(expected, actual)
        end
    end
end

