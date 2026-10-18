
void main()
{
    int[] values = selectionWithoutReplacement(20, 10, 100);
    System.out.println(toString(" ", values));

    int minTarget = values[0] - 1;
    int maxTarget = values[values.length - 1] + 1;

    for (int target = minTarget; target <= maxTarget; target++)
    {
        int index = binarySearch(values, target);
        System.out.printf("target = %d, index = %d\n", target, index);
    }
}

int[] selectionWithoutReplacement(int n, int begin, int end)
{
    int[] values = new int[n];
    int nSelected = 0;

    for (int value = begin; value < end; value++)
    {
        int nRemaining = n - nSelected;
        int nCandidatesRemaining = end - value;
        double selectionProbability = nRemaining / (double) nCandidatesRemaining;

        if (Math.random() < selectionProbability)
            values[nSelected++] = value;
    }

    return values;
}

String toString(String separator, int[] array)
{
    return Arrays
            .stream(array)
            .mapToObj(String::valueOf)
            .collect(Collectors.joining(separator));
}

int binarySearch(int[] values, int target)
{
    return binarySearch(values, target, 0, values.length - 1);
}

int binarySearch(int[] values, int target, int first, int last)
{
    if (first > last)
        return -1;

    int center = (first + last) / 2;

    if (target == values[center])
        return center;

    if (target < values[center])
        return binarySearch(values, target, first, center - 1);
    else
        return binarySearch(values, target, center + 1, last);
}

