
module MyString

    def prefixes
        (0..size).map do |n|
            self[0...n]
        end
    end

    def proper_prefixes
        (0...size).map do |n|
            self[0...n]
        end
    end

    def suffixes
        (0..size).map do |n|
            self[size-n..size]
        end
    end

    def proper_suffixes
        (0...size).map do |n|
            self[size-n..size]
        end
    end

    def lps
        (proper_prefixes & proper_suffixes).max_by(&:size)
    end

    def lps_array
        prefixes[1..].map(&:lps).map(&:size)
    end

end

class String

    include MyString

end

