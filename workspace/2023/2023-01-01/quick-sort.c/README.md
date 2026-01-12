# quick-sort.c

## Functions

    void initialize();
        プログラム全体の初期化 (乱数の初期化など) を行います.

    void set_random_values(int *values, int size);
        配列の各要素に乱数値を設定します.

    int is_sorted(const int *values, int size);
        配列が昇順に整列されているか判定します.

    void print_values(const int *values, int size);
        配列の内容を表示します.

    void quick_sort(int *values, int size);
        配列をクイックソートによって整列します.

    void _quick_sort(int *values, int lower, int upper);
        quick_sort() の内部実装です.

    void swap(int *values, int index1, int index2);
        配列の中の 2 つの値を交換します.

