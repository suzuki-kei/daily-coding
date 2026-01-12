
void quick_sort_range(int *values, int lower, int upper);
void swap(int *values, int index1, int index2);

void quick_sort(int *values, int size)
{
    quick_sort_range(values, 0, size - 1);
}

void quick_sort_range(int *values, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const int pivot = values[(lower + upper) / 2];

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++;
        while (pivot < values[upper_index])
            upper_index--;
        if (lower_index <= upper_index)
            swap(values, lower_index++, upper_index--);
    }

    if (lower < upper_index)
        quick_sort_range(values, lower, upper_index);
    if (lower_index < upper)
        quick_sort_range(values, lower_index, upper);
}

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

