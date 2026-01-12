#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test();
void test_is_prefix();
void test_linear_search();
int is_prefix(const char *text, const char *prefix);
int linear_search(const char *text, const char *pattern);

int main(void)
{
    test();
    return 0;
}

void test()
{
    test_is_prefix();
    test_linear_search();
}

void test_is_prefix()
{
    assert(is_prefix("", "") == 1);
    assert(is_prefix("a", "") == 1);
    assert(is_prefix("", "a") == 0);
    assert(is_prefix("a", "a") == 1);
    assert(is_prefix("a", "b") == 0);
    assert(is_prefix("b", "a") == 0);
    assert(is_prefix("abracatabra", "") == 1);
    assert(is_prefix("abracatabra", "a") == 1);
    assert(is_prefix("abracatabra", "ab") == 1);
    assert(is_prefix("abracatabra", "abr") == 1);
}

void test_linear_search()
{
    assert(linear_search("", "") == 0);
    assert(linear_search("a", "") == 0);
    assert(linear_search("", "a") == -1);
    assert(linear_search("a", "a") == 0);
    assert(linear_search("abracatabra", "abracatabra") == 0);
    assert(linear_search("abracatabra", "bracatabra") == 1);
    assert(linear_search("abracatabra", "racatabra") == 2);
    assert(linear_search("abracatabra", "acatabra") == 3);
    assert(linear_search("abracatabra", "catabra") == 4);
    assert(linear_search("abracatabra", "atabra") == 5);
    assert(linear_search("abracatabra", "tabra") == 6);
    assert(linear_search("abracatabra", "abra") == 0);
    assert(linear_search("abracatabra", "bra") == 1);
    assert(linear_search("abracatabra", "ra") == 2);
    assert(linear_search("abracatabra", "a") == 0);
    assert(linear_search("abracatabra", "") == 0);
}

int is_prefix(const char *text, const char *prefix)
{
    int i = 0;

    while (text[i] != '\0' && prefix[i] != '\0' && text[i] == prefix[i])
        i++;

    if (prefix[i] == '\0')
        return 1;
    else
        return 0;
}

int linear_search(const char *text, const char *pattern)
{
    int i;

    if (pattern[0] == '\0')
        return 0;
    for (i = 0; text[i] != '\0'; i++)
        if (is_prefix(&text[i], pattern))
            return i;
    return -1;
}

