(use gauche.test)
(load "parameterized-testing")
(load "set")
(load "mathematics")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.factorial)
        (test.permutation)
        (test.combination)
        (test.tree->list)
        (test.permutations)
        (test.combinations)))

(define test.factorial
    (lambda ()
        (test-start "factorial")
        (parameterized.test* '(
                ; (expected n)
                (1 0)
                (1 1)
                (2 2)
                (6 3)
                (24 4)
                (120 5))
            factorial)
        (test-end)))

(define test.permutation
    (lambda ()
        (test-start "permutation")
        (parameterized.test* '(
                ; (expected n=0 k)
                (1 0 0)
                (0 0 1)
                ; (expected n=1 k)
                (1 1 0)
                (1 1 1)
                (0 1 2)
                ; (expected n=2 k)
                (1 2 0)
                (2 2 1)
                (2 2 2)
                (0 2 3)
                ; (expected n=3 k)
                (1 3 0)
                (3 3 1)
                (6 3 2)
                (6 3 3)
                (0 3 4))
            permutation)
        (test-end)))

(define test.combination
    (lambda ()
        (test-start "combination")
        (parameterized.test* '(
                ; (expected n=0 k)
                (1 0 0)
                (0 0 1)
                ; (expected n=1 k)
                (1 1 0)
                (1 1 1)
                (0 1 2)
                ; (expected n=2 k)
                (1 2 0)
                (2 2 1)
                (1 2 2)
                (0 2 3)
                ; (expected n=3 k)
                (1 3 0)
                (3 3 1)
                (3 3 2)
                (1 3 3)
                (0 3 4))
            combination)
        (test-end)))

(define test.tree->list
    (lambda ()
        (test-start "tree->list with atom?")
        (parameterized.test* '(
                ; (expected tree)
                (()          ())
                ((a)         (a))
                ((a)         ((a)))
                ((a b c d e) (a (b) ((c d) e))))
            (lambda (tree)
                (tree->list tree atom?)))
        (test-end)

        (test-start "tree->list with flatten?")
        (parameterized.test* '(
                ; (expected tree)
                (()                  ())
                (((a 1) (b 2) (c 3)) ((a 1) ((b 2)) (((c 3))))))
            (lambda (tree)
                (tree->list tree flatten?)))
        (test-end)))

(define test.permutations
    (lambda ()
        (test-start "permutations")
        (parameterized.test* '(
                ; (expected xs n)
                (()                                                (a b c) 0)
                (((a) (b) (c))                                     (a b c) 1)
                (((a b) (a c) (b a) (b c) (c a) (c b))             (a b c) 2)
                (((a b c) (a c b) (b a c) (b c a) (c a b) (c b a)) (a b c) 3))
            permutations
            set-equal?)
        (test-end)))

(define test.combinations
    (lambda ()
        (test-start "combinations")
        (parameterized.test* '(
                ; (expected xs n)
                (()                  (a b c) 0)
                (((a) (b) (c))       (a b c) 1)
                (((a b) (a c) (b c)) (a b c) 2)
                (((a b c))           (a b c) 3))
            combinations
            set-equal?)
        (test-end)))

