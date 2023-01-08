
(use gauche.test)
(load "parameterized-testing.scm")
(load "run-length-encoding.scm")

(define TEST-DATA-TUPLES '(
    ; (xs runs encoded-runs)
    (()             ()                  ())
    ((a)            ((a))               ((a . 1)))
    ((a a)          ((a a))             ((a . 2)))
    ((a a a)        ((a a a))           ((a . 3)))
    ((a b)          ((a) (b))           ((a . 1) (b . 1)))
    ((a b b)        ((a) (b b))         ((a . 1) (b . 2)))
    ((a a b c c c)  ((a a) (b) (c c c)) ((a . 2) (b . 1) (c . 3)))))

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.encode/decode)
        (test.encode)
        (test.xs->runs)
        (test.runs->encoded-runs)
        (test.run->encoded-run)
        (test.decode)
        (test.encoded-runs->xs)
        (test.encoded-run->run)
        (test.runs->xs)))

(define test.encode/decode
    (lambda ()
        (test-start "encode/decode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode (encode xs)))))
        (test-end)))

(define test.encode
    (lambda ()
        (test-start "encode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    encoded-runs
                    (encode xs))))
        (test-end)))

(define test.xs->runs
    (lambda ()
        (test-start "xs->runs")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    runs
                    (xs->runs xs))))
        (test-end)))

(define test.runs->encoded-runs
    (lambda ()
        (test-start "runs->encoded-runs")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    encoded-runs
                    (runs->encoded-runs runs))))
        (test-end)))

(define test.run->encoded-run
    (lambda ()
        (test-start "run->encoded-run")
        (test* "#1" '(a . 1) (run->encoded-run '(a)))
        (test* "#2" '(a . 2) (run->encoded-run '(a a)))
        (test* "#3" '(a . 3) (run->encoded-run '(a a a)))
        (test-end)))

(define test.decode
    (lambda ()
        (test-start "decode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode encoded-runs))))
        (test-end)))

(define test.encoded-runs->xs
    (lambda ()
        (test-start "encoded-runs->xs")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (encoded-runs->xs encoded-runs))))
        (test-end)))

(define test.encoded-run->run
    (lambda ()
        (test-start "encoded-run->run")
        (test* "#1" '(a) (encoded-run->run '(a . 1)))
        (test* "#2" '(a a) (encoded-run->run '(a . 2)))
        (test* "#3" '(a a a) (encoded-run->run '(a . 3)))
        (test-end)))

(define test.runs->xs
    (lambda ()
        (test-start "runs->xs")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (runs->xs runs))))
        (test-end)))

