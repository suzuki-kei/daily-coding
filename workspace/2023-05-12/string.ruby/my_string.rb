
module MyString

    module Methods

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
                self[size-n...size]
            end
        end

        def proper_suffixes
            (0...size).map do |n|
                self[size-n...size]
            end
        end

        def lps
            prefixes[1..].map do |substring|
                (substring.proper_prefixes & substring.proper_suffixes).map(&:size).max
            end
        end

    end

    include Methods

    class << self
        include Methods
    end

end

class String

    include MyString

end

