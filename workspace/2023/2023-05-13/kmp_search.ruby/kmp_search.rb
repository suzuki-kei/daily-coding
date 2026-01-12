
def create_lps_array(string)
    lps_array = [0] * string.size
    index = 1
    length = 0

    while index < string.size
        if string[index] == string[length]
            lps_array[index] = length + 1
            index += 1
            length += 1
        else
            if length == 0
                lps_array[index] = 0
                index += 1
            else
                length = lps_array[length - 1]
            end
        end
    end

    lps_array
end

def kmp_search(string, pattern)
    if pattern.empty?
        return 0
    end

    lps_array = create_lps_array(pattern)
    string_index = 0
    pattern_index = 0

    while string_index < string.size
        if string[string_index] == pattern[pattern_index]
            string_index += 1
            pattern_index += 1
        end

        if pattern_index == pattern.size
            return string_index - pattern_index
        end

        if string_index == string.size
            return -1
        end

        if string[string_index] != pattern[pattern_index]
            if pattern_index == 0
                string_index += 1
            else
                pattern_index = lps_array[pattern_index - 1]
            end
        end
    end

    -1
end

