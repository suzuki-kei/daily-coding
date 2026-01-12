
def parameterized(name, xs_expected_map)
    xs_expected_map.each_with_index do |(xs, expected), index|
        define_method("test_#{name}_#{index + 1}") do
            actual = method(name)[xs]
            assert_equal expected, actual
        end
    end
end

