<?php

class User
{
    private string $name;
    private int $age;

    function __construct(string $name, int $age)
    {
        $this->name = $name;
        $this->age = $age;
    }

    function getName()
    {
        return $this->name;
    }

    function getAge()
    {
        return $this->age;
    }

}

function main()
{
    $user = new User('taro', 10);
    echo 'name=', $user->getName(), "\n";
    echo 'age=', $user->getAge(), "\n";
}

main();

?>

