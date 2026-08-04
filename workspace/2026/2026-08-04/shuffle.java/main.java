import java.util.random.RandomGenerator;

void main()
{
    int[] array = sequence(0, 9);
    printArray(array);
    shuffle(array);
    printArray(array);
}

int[] sequence(int min, int max)
{
    int[] array = new int[max - min + 1];

    for (int i = 0; i < array.length; i++)
        array[i] = i + min;

    return array;
}

void printArray(int[] array)
{
    System.out.println(
        Arrays.stream(array)
              .mapToObj(String::valueOf)
              .collect(Collectors.joining(" ")));
}

void shuffle(int[] array)
{
    for (int i = 0; i < array.length - 1; i++)
        swap(array, i, randomRange(i, array.length - 1));
}

int randomRange(int min, int max)
{
    return RandomGenerator.getDefault().nextInt(min, max + 1);
}

void swap(int[] array, int index1, int index2)
{
    int temporary = array[index1];
    array[index1] = array[index2];
    array[index2] = temporary;
}

