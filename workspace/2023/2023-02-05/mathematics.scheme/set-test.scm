(use gauche.test)
(load "parameterized-testing")
(load "set")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.include?)
        (test.list->set)
        (test.set?)
        (test.set-include?)
        (test.set-equal?)
        (test.set-union)
        (test.set-difference)
        (test.set-intersection)))

(define test.include?
    (lambda ()
        (test-start "include?")
        (parameterized.test* '(
                ; (expected x xs)
                (#f 0 ())
                (#f 0 (1 2 3))
                (#t 1 (1 2 3))
                (#t 2 (1 2 3))
                (#t 3 (1 2 3))
                (#f 4 (1 2 3)))
            include?)
        (test-end)))

(define test.list->set
    (lambda ()
        (test-start "list->set")
        (parameterized.test* '(
                ; (expected xs)
                (()      ())
                ((1)     (1))
                ((1)     (1 1))
                ((1 2)   (1 2))
                ((1 2 3) (1 1 2 3 3 3)))
            list->set
            set-equal?)
        (test-end)))

(define test.set?
    (lambda ()
        (test-start "set?")
        (parameterized.test* '(
                ; (expected xs)
                (#t ())
                (#t (1))
                (#t (1 2))
                (#t (1 2 3))
                (#f (1 1))
                (#f (1 2 1)))
            set?)
        (test-end)))

(define test.set-include?
    (lambda ()
        (test-start "set-include?")
        (parameterized.test* '(
                ; (expected set1 set2)
                (#t ()      ())
                (#t ()      (1 2 3))
                (#t (1)     (1 2 3))
                (#t (1 2)   (1 2 3))
                (#t (1 2 3) (1 2 3))
                (#f (1)     ())
                (#f (1 2 3) (2 3 4))
                (#f (1 2 3) (3 4 5))
                (#f (1 2 3) (4 5 6)))
            set-include?)
        (test-end)))

(define test.set-equal?
    (lambda ()
        (test-start "set-equal?")
        (parameterized.test* '(
                ; (expected set1 set2)
                (#t ()      ())
                (#f (1)     ())
                (#f ()      (1))
                (#f (1 2)   (2 3))
                (#t (1 2 3) (1 2 3))
                (#t (1 2 3) (2 3 1))
                (#t (1 2 3) (3 1 2)))
            set-equal?)
        (test-end)))

(define test.set-union
    (lambda ()
        (test-start "set-union")
        (parameterized.test* '(
                ; (expected set1 set2)
                (()      ()      ())
                ((1 2 3) (1 2 3) ())
                ((1 2 3) (1 2 3) (3))
                ((1 2 3) (1 2 3) (3 2))
                ((1 2 3) (1 2 3) (3 2 1))
                ((1 2 3) ()      (1 2 3))
                ((1 2 3) (3)     (1 2 3))
                ((1 2 3) (3 2)   (1 2 3))
                ((1 2 3) (3 2 1) (1 2 3)))
            set-union
            set-equal?)
        (test-end)))

(define test.set-difference
    (lambda ()
        (test-start "set-difference")
        (parameterized.test* '(
                ; (expected set1 set2)
                (()      ()      ())
                (()      ()      (1))
                (()      ()      (1 2))
                (()      ()      (1 2 3))
                ((1 2 3) (1 2 3) ())
                ((1 2)   (1 2 3) (3))
                ((1)     (1 2 3) (3 2))
                (()      (1 2 3) (3 2 1)))
            set-difference
            set-equal?)
        (test-end)))

(define test.set-intersection
    (lambda ()
        (test-start "set-intersection")
        (parameterized.test* '(
                ; (expected set1 set2)
                (()      ()      ())
                (()      (1)     ())
                (()      ()      (1))
                ((1)     (1)     (1))
                ((1 2 3) (1 2 3) (1 2 3))
                ((2 3)   (1 2 3) (2 3 4))
                ((3)     (1 2 3) (3 4 5))
                (()      (1 2 3) (4 5 6)))
            set-intersection
            set-equal?)
        (test-end)))

