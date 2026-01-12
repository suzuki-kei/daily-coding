
void quick_sort_range(int *values, int lower, int upper);
void swap(int *values, int index1, int index2);

void bubble_sort(int *values, int size)
{
    int i;
    int unsorted_size;

    for (unsorted_size = size; unsorted_size > 0; unsorted_size--)
        for (i = 0; i < unsorted_size - 1; i++)
            if (values[i] > values[i + 1])
                swap(values, i, i + 1);
}

void selection_sort(int *values, int size)
{
    int i;
    int unsorted_size;
    int maximum_index;

    for (unsorted_size = size; unsorted_size > 0; unsorted_size--)
    {
        for (maximum_index = 0, i = 1; i < unsorted_size; i++)
            if (values[i] > values[maximum_index])
                maximum_index = i;
        swap(values, unsorted_size - 1, maximum_index);
    }
}

void insertion_sort(int *values, int size)
{
    int i;
    int sorted_size;

    for (sorted_size = 1; sorted_size < size; sorted_size++)
        for (i = sorted_size; i > 0 && values[i] < values[i - 1]; i--)
            swap(values, i, i - 1);
}

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

