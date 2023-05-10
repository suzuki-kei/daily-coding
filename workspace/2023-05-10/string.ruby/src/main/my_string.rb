
module MyString

    def prefixes
        (0..size).map do |n|
            self[0...n]
        end
    end

    def prefix?(string)
        start_with?(string)
    end

    def proper_prefixes
        (0...size).map do |n|
            self[0...n]
        end
    end

    def proper_prefix?(string)
        size != string.size && prefix?(string)
    end

    def suffixes
        (0..size).map do |n|
            self[size-n...size]
        end
    end

    def suffix?(string)
        end_with?(string)
    end

    def proper_suffixes
        (0...size).map do |n|
            self[size-n...size]
        end
    end

    def proper_suffix?(string)
        size != string.size && suffix?(string)
    end

    def lps
        (proper_prefixes & proper_suffixes).sort_by(&:size).last
    end

    def lps_array
        prefixes[1..].map(&:lps).map(&:size)
    end

end

class String

    prepend MyString

end

