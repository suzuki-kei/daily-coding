# searching

 * LPS Array (Longest proper Prefix Suffix Array)
   - array[i] が文字列の先頭 i 文字を含む proper suffix

## Reference

 * https://medium.com/@aakashjsr/preprocessing-algorithm-for-kmp-search-lps-array-algorithm-50e35b5bb3cb

LPS is simply the name of the array that we're trying to build
where the value at an index 'i' indicates the length of the longest proper prefix
which is also the same as the proper suffix for the string containing the first 'i' characters.

LPS とはインデックス i が文字列の先頭 i 文字を含む proper suffix と一致する最長の proper prefix の長さを意味する配列である.

 * LPS とは配列である.
 * LPS[i] = 文字列の先頭 i 文字を含む proper suffix と一致する最長の proper prefix の長さ.

## Understanding the LPS array

If the pattern/string that we're considering is " a a c a a a a c " then length of the LPS array would be 8.

もし pattern/string が "aacaaaac" ならば LPS 配列の長さは 8 となる.

LPS[4] would store the length of the longest proper prefix
which same as the proper suffix of the string formed using the first 5 characters (" a a c a a ") of the pattern
i.e from index 0 to index 4.

LPS[4] には pattern の先頭 5 文字 ("aacaa") の proper suffix と一致する最長の proper prefix となる.
インデックスは 0 から 4 である.

