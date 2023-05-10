
module KmpSearch

    module Methods

        #
        # LPS (Longest proper Prefix Suffix) 配列を作成する.
        #
        # NOTE:
        #  * index は配列 lps のインデックス.
        #  * length は計算中の longest prefix の長さ.
        #  * lps[i] は部分文字列 pattern[0..i] の LPS の長さ.
        #
        def create_lps_array(pattern)
            lps    = [0] * pattern.size
            index  = 1
            length = 0

            while index < pattern.size
                if pattern[index] == pattern[length]
                    lps[index]  = length + 1
                    index      += 1
                    length     += 1
                else
                    if length == 0
                        lps[index]  = 0
                        index      += 1
                    else
                        length = lps[length - 1]
                    end
                end
            end

            lps
        end

        #
        # KMP 法で文字列を検索する.
        #
        def kmp_search(string, pattern)
            if pattern.empty?
                return 0
            end

            lps           = create_lps_array(pattern)
            string_index  = 0
            pattern_index = 0

            while string_index < string.size
                if string[string_index] == pattern[pattern_index]
                    string_index  += 1
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
                        pattern_index = lps[pattern_index - 1]
                    end
                end
            end

            -1
        end

    end

    include KmpSearch::Methods

    class << self
        include KmpSearch::Methods
    end

end

