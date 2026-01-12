
class Probabilities

    # 嘘つきが嘘を言う確率.
    attr_reader :liar_say_lie

    # 嘘つきが正直に言う確率.
    attr_reader :liar_say_truth

    # 正直者が嘘を言う確率.
    attr_reader :honest_say_lie

    # 正直者が正直に言う確率.
    attr_reader :honest_say_truth

    def initialize(liar_say_lie:, honest_say_lie:)
        @liar_say_lie = liar_say_lie.to_f
        @liar_say_truth = 1.0 - liar_say_lie
        @honest_say_lie = honest_say_lie
        @honest_say_truth = 1.0 - honest_say_lie
    end

end

