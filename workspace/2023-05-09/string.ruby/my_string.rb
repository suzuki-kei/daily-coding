
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
            self[n...size]
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

    def borders
        prefixes.select do |prefix|
            suffix?(prefix)
        end
    end

    def border?(string)
        prefix?(string) && suffix?(string)
    end

    def substring?(string)
        include?(string)
    end

    def superstring_of?(strings)
        strings.all? do |string|
            substring?(string)
        end
    end

end

class String

    prepend MyString

end

