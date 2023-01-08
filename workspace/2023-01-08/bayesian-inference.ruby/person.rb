
class Person

    attr_reader :liar_probability
    attr_reader :honest_probability
    attr_reader :probabilities

    def initialize(liar_probability:, probabilities:)
        @liar_probability = liar_probability.to_f
        @honest_probability = 1.0 - liar_probability.to_f
        @probabilities = probabilities
    end

    def to_s
        sprintf('(liar=%.4f, honest=%.4f)', @liar_probability, @honest_probability)
    end

    def say(say_flags)
        if say_flags
            self.say_truth
        else
            self.say_lie
        end
    end

    private

    def say_lie
        # この人が嘘つき, かつ嘘を言った確率.
        p1 = @liar_probability * @probabilities.liar_say_lie

        # この人が正直者, かつ嘘を言った確率.
        p2 = @honest_probability * @probabilities.honest_say_lie

        @liar_probability = p1 / (p1 + p2)
        @honest_probability = p2 / (p1 + p2)
    end

    def say_truth
        # この人が嘘つき, かつ正直に言った確率.
        p1 = @liar_probability * @probabilities.liar_say_truth

        # この人が正直者, かつ正直に言った確率.
        p2 = @honest_probability * @probabilities.honest_say_truth

        @liar_probability = p1 / (p1 + p2)
        @honest_probability = p2 / (p1 + p2)
    end

end

