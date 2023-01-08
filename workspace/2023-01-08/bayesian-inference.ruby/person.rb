
LIAR_SAY_LIE_PROBABILITY = 0.8
LIAR_SAY_HONEST_PROBABILITY = 1.0 - LIAR_SAY_LIE_PROBABILITY
HONEST_SAY_LIE_PROBABILITY = 0.1
HONEST_SAY_HONEST_PROBABILITY = 1.0 - HONEST_SAY_LIE_PROBABILITY

class Person

    attr_reader :liar_probability
    attr_reader :honest_probability

    def initialize(liar_probability)
        @liar_probability = liar_probability.to_f
        @honest_probability = 1.0 - liar_probability.to_f
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

    def say_lie
        # この人が嘘つき, かつ嘘を言った確率.
        p1 = @liar_probability * LIAR_SAY_LIE_PROBABILITY

        # この人が正直者, かつ嘘を言った確率.
        p2 = @honest_probability * HONEST_SAY_LIE_PROBABILITY

        @liar_probability = p1 / (p1 + p2)
        @honest_probability = p2 / (p1 + p2)
    end

    def say_truth
        # この人が嘘つき, かつ正しいことを言った確率.
        p1 = @liar_probability * LIAR_SAY_HONEST_PROBABILITY

        # この人が正直者, かつ正しいことを言った確率.
        p2 = @honest_probability * HONEST_SAY_HONEST_PROBABILITY

        @liar_probability = p1 / (p1 + p2)
        @honest_probability = p2 / (p1 + p2)
    end

end

