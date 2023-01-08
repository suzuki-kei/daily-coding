require './person.rb'

def main
    (1..3).each do |n|
        puts '=' * 80
        send("simulate#{n}")
    end
end

def simulate1
    puts <<~"EOS"
        #{__method__}::
            嘘つきである確率の初期値ごとに,
            何回か発言した時の確率の変化を確認する.

    EOS

    say_flags = [true] * 5 + [false] * 3

    puts <<~"EOS"
        parameters::
            say_flags=#{say_flags}

    EOS

    results = (1..9).map{|x| x / 10.0}.map do |initial_liar_probability|
        person = Person.new(initial_liar_probability)

        say_flags.each do |say_flag|
            person.say(say_flag)
        end

        [
            "initial_liar_probability=#{initial_liar_probability}",
            "person=#{person}",
        ].join(', ')
    end

    puts 'result::'
    puts results.join("\n").gsub(/^/, '    ')
    puts
end

def simulate2
    puts <<~"EOS"
        #{__method__}::
            嘘つきである確率の初期値ごとに,
            何回嘘を言い続けると嘘つきである確率が 0.95 以上になるか.

    EOS

    results = (1..9).map{|x| x / 10.0}.map do |initial_liar_probability|
        n = 0
        person = Person.new(initial_liar_probability)

        while person.liar_probability < 0.95
            n += 1
            person.say(false)
        end

        [
            "initial_liar_probability=#{initial_liar_probability}",
            "n=#{n}",
            "person=#{person}",
        ].join(', ')
    end

    puts 'result::'
    puts results.join("\n").gsub(/^/, '    ')
    puts
end

def simulate3
    puts <<~"EOS"
        #{__method__}::
            発言の順番によって最終的な確率が変化するか.

    EOS

    say_flags = [true] * 5 + [false] * 3
    initial_liar_probability = 0.5

    puts <<~"EOS"
        parameters::
            say_flags=#{say_flags} (to be shuffle)
            initial_liar_probability=#{initial_liar_probability}

    EOS

    results = 10.times.map do
        n = 0
        person = Person.new(initial_liar_probability)
        shuffled_say_flags = say_flags.shuffle

        shuffled_say_flags.each do |say_flag|
            person.say(say_flag)
        end

        [
            "say_flags=#{shuffled_say_flags}",
            "person=#{person}",
        ].join(', ')
    end

    puts 'result::'
    puts results.join("\n").gsub(/^/, '    ')
    puts
end

main

