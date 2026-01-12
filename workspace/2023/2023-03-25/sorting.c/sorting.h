#ifndef SORTING_H_INCLUDED
#define SORTING_H_INCLUDED

typedef void (*sorting_fn)(int *values, int size);

void insertion_sort(int *values, int size);
void selection_sort(int *values, int size);
void quick_sort(int *values, int size);

#endif

