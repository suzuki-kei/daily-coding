
def main
    word = %w(
        テスト
        上下左右
        一二三四
        こんにちは
    )
    puts optical_illusion(word.sample)
end

def optical_illusion(text, n: 3, c: '＋')
    line1 = "#{c}#{text}" * n
    line2 = "#{text}#{c}" * n

    <<~"EOS"
        #{line1}
         #{line1}
          #{line1}

          #{line2}
         #{line2}
        #{line2}

        #{line1}
         #{line1}
          #{line1}
    EOS
end

main if $0 == __FILE__

