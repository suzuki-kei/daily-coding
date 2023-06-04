(use gauche.test)
(load "parameterized")
(load "run-length-encoding")

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()             ())
    ((a)            ((a . 1)))
    ((a a)          ((a . 2)))
    ((a a a)        ((a . 3)))
    ((a b)          ((a . 1) (b . 1)))
    ((a b b)        ((a . 1) (b . 2)))
    ((a a b c c c)  ((a . 2) (b . 1) (c . 3)))))

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.xs->runs)
        (test.run->encoded-run)
        (test.runs->encoded-runs)
        (test.encode)
        (test.decode)
        (test.encode/decode)))

(define test.encode/decode
    (lambda ()
        (test-start "encode/decode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "~d" (+ index 1))
                    xs
                    (decode (encode xs))))
            TEST-DATA-TUPLES)
        (test-end)))

(define test.encode
    (lambda ()
        (test-start "encode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "~d" (+ index 1))
                    encoded-runs
                    (encode xs)))
            TEST-DATA-TUPLES)
        (test-end)))

(define test.decode
    (lambda ()
        (test-start "decode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "~d" (+ index 1))
                    xs
                    (decode encoded-runs)))
            TEST-DATA-TUPLES)
        (test-end)))

(define test.xs->runs
    (lambda ()
        (test-start "xs->runs")
        (test* "#1" '() (xs->runs '()))
        (test* "#2" '((a)) (xs->runs '(a)))
        (test* "#3" '((a a)) (xs->runs '(a a)))
        (test* "#4" '((a) (b)) (xs->runs '(a b)))
        (test-end)))

(define test.runs->encoded-runs
    (lambda ()
        (test-start "runs->encoded-runs")
        (test* "#1" '() (runs->encoded-runs '()))
        (test* "#2" '((a . 1)) (runs->encoded-runs '((a))))
        (test* "#3" '((a . 2)) (runs->encoded-runs '((a a))))
        (test* "#4" '((a . 1) (b . 1)) (runs->encoded-runs '((a) (b))))
        (test-end)))

(define test.run->encoded-run
    (lambda ()
        (test-start "run->encoded-run")
        (test* "#1" '(a . 1) (run->encoded-run '(a)))
        (test* "#2" '(a . 2) (run->encoded-run '(a a)))
        (test* "#3" '(a . 3) (run->encoded-run '(a a a)))
        (test-end)))

