(use gauche.test)
(load "intersperse")

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "intersperse")
        (test-intersperse)
        (test-end)))

(define test-intersperse
    (lambda ()
        (test-section "intersperse")
        (test* "#1" '() (intersperse 'x '()))
        (test* "#2" '(a) (intersperse 'x '(a)))
        (test* "#3" '(a x b) (intersperse 'x '(a b)))
        (test* "#4" '(a x b x c) (intersperse 'x '(a b c)))
        (test* "#5" '(a _ b _ c) (intersperse '_ '(a b c)))))

