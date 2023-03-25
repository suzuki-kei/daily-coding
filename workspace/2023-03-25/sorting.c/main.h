#ifndef MAIN_H_INCLUDED
#define MAIN_H_INCLUDED

#include "sorting.h"

#define SIZE 20
#define DEMONSTRATION(name) demonstration(#name, name)

void initialize();
void demonstration(const char *name, sorting_fn sorting);
void set_random_values(int *values, int size);
void print_values(int *values, int size);
int is_sorted(int *values, int size);

#endif

