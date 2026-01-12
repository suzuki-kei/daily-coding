(use gauche.test)
(load "intersperse")

(define main
    (lambda (_)
        (test-intersperse-module)))

(define test-intersperse-module
    (lambda ()
        (test-start "intersperse")
        (test-intersperse-intersperse)
        (test-end)))

(define test-intersperse-intersperse
    (lambda ()
        (test-section "intersperse")
        (test* "#1" '() (intersperse 'x '()))
        (test* "#2" '(a) (intersperse 'x '(a)))
        (test* "#3" '(a x b) (intersperse 'x '(a b)))
        (test* "#4" '(a x b x c) (intersperse 'x '(a b c)))))

