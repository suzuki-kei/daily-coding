
def parameterized(name, tuples)
    tuples.each_with_index do |(expected, *arguments), index|
        define_method("test_#{name}_#{index + 1}") do
            actual = method(name).call(*arguments)
            assert_equal(expected, actual)
        end
    end
end

