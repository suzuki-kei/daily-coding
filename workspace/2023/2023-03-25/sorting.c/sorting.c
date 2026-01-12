
void swap(int *values, int index1, int index2);
void _quick_sort(int *values, int lower, int upper);

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

void insertion_sort(int *values, int size)
{
    int i;
    int sorted_size;

    for (sorted_size = 1; sorted_size <= size; sorted_size++)
        for (i = sorted_size - 1; i > 0; i--)
            if (values[i] < values[i - 1])
                swap(values, i, i - 1);
}

void selection_sort(int *values, int size)
{
    int i;
    int lower;
    int minimum_index;

    for (lower = 0; lower < size; lower++)
    {
        for (minimum_index = lower, i = lower + 1; i < size; i++)
            if (values[i] < values[minimum_index])
                minimum_index = i;
        swap(values, lower, minimum_index);
    }
}

void quick_sort(int *values, int size)
{
    _quick_sort(values, 0, size - 1);
}

void _quick_sort(int *values, int lower, int upper)
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
        _quick_sort(values, lower, upper_index);
    if (lower_index < upper)
        _quick_sort(values, lower_index, upper);
}

