
void swap(int *values, int index1, int index2);

void insertion_sort(int *values, int size)
{
    int i;
    int sorted_size;

    for (sorted_size = 1; sorted_size <= size; sorted_size++)
        for (i = sorted_size; i > 0 && values[i - 1] > values[i]; i--)
            swap(values, i, i - 1);
}

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

