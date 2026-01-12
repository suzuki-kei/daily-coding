
typedef void (*set_values_t)(int *values, int size);

void initialize();
void demonstration();
void test(set_values_t set_values);
void _test(int size, set_values_t set_values, int verbose);
void copy_values(const int *source, int *destination, int size);
void print_values(const char *description, const int *values, int size);
int is_sorted(const int *values, int size);
void set_random_values(int *values, int size);
void set_constant_values(int *values, int size);
void set_ascending_values(int *values, int size);
void set_descending_values(int *values, int size);

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

