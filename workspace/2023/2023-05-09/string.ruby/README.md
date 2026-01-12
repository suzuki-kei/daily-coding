# string

## Reference

 * https://en.wikipedia.org/wiki/Substring
 * https://en.wikipedia.org/wiki/String_operations

## prefix と suffix

 * t = p + s が成立する場合, p は t の prefix, s は t の suffix である.
   - 例: t="abcde", p="", s="abcde"
   - 例: t="abcde", p="a", s="bcde"
   - 例: t="abcde", p="ab", s="cde"
   - 例: t="abcde", p="abc", s="de"
   - 例: t="abcde", p="abcd", s="e"
   - 例: t="abcde", p="abcde", s=""

 * prefix の条件に p != t, p != "", suffix の条件に s != t, s != "" を加えることがある.
   - p != t である場合, p を t の proper prefix という.
   - s != t である場合, s を t の proper suffix という.

 * p ⊑ t (square subset symbol) は p が t の prefix であることを意味する.
   - これは特定の種類の prefix order である, prefix relation と呼ばれる文字列における binary relation を定義する.

## substring

 * t = p + u + s が存在する場合, u を t の substring という.
   - 例: t="banana", p="ba", u="na", s="na"

 * 空文字列はあらゆる文字列の substring である.
   - 例: t="banana", p="banana", u="", s=""
   - 例: t="banana", p="ban", u="", s="ana"
   - 例: t="banana", p="", u="", s="banana"

 * "ana" は 2 つのオフセットにおいて "banana" の substring である.
   - 例: t="banana", p="b", u="ana", s="na"
   - 例: t="banana", p="ban", u="ana", s=""

 * 最長共通部分文字列問題 (longest common substring problem)
   - 2 つ以上の文字列の substring と一致する最長の文字列を見つけること.

## prefix, suffix, substring の関係

 * substring は suffix の purefix であり, prefix の suffix である.
   - 例: "nan" は "banana" の suffix である "nana" の prefix.
   - 例: "nan" は "banana" の prefix である "bana" の suffix.

 * prefix と suffix は substring の特殊ケースと見なすことができる.
   - 例: t="abcde" に対する "abc" は prefix であり substring でもある.
   - 例: t="abcde" に対する "cde" は suffix であり substring でもある.

## suffix tree と suffix array

 * suffix tree
   - 全ての suffix を表現した Trie である.

 * suffix array
   - suffix tree を簡略化したデータ構造である.
   - suffix の開始位置をアルファベット順にソートしたリストである.

## border

 * 同じ値である prefix と suffix を border という.
   - 例: t="babab", prefix="bab", suffix="bab", border="bab"
   - 例: t="baboon eating a kebab", prefix="bab", suffix="bab", border="bab"

## superstring

 * 有限集合 P の全要素を substring として持つ文字列を P の superstring という.
   - 例: t="bcclabccefab", P={"abcc", "efab", "bccla"}
   - 例: t="efabccla", P={"abcc", "efab", "bccla"}

 * P の全要素を任意の順番で結合することは P の superstring を得る自明な方法である.
   - 例: t="abccefabbccla", P={"abcc", "efab", "bccla"}

