
def prefixes(text):
    return list(map(
        lambda n: text[0:n],
        range(0, len(text) + 1)))


def proper_prefixes(text):
    return list(map(
        lambda n: text[0:n],
        range(0, len(text))))


def suffixes(text):
    return list(map(
        lambda n: text[len(text)-n:],
        range(0, len(text) + 1)))


def proper_suffixes(text):
    return list(map(
        lambda n: text[len(text)-n:],
        range(0, len(text))))


def lps(text):
    proper_prefix_set = set(proper_prefixes(text))
    proper_suffix_set = set(proper_suffixes(text))
    intersection = proper_prefix_set.intersection(proper_suffix_set)

    if not intersection:
        return None
    return sorted(intersection, key=len)[-1]


def lps_array(text):
    return list(map(len, map(lps, prefixes(text)[1:])))

