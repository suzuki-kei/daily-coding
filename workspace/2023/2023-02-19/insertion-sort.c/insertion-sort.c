
void swap(int *values, int index1, int index2);

void insertion_sort(int *values, int size)
{
    int i;
    int lower;
    int minimum;

    for (lower = 0; lower < size; lower++)
    {
        for (i = minimum = lower; i < size; i++)
            if (values[i] < values[minimum])
                minimum = i;
        swap(values, lower, minimum);
    }
}

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

