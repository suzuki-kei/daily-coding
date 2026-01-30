(use gauche.test)
(load "intersperse")

(define-syntax labelled-test
    (syntax-rules ()
        ((_ test-case target)
            (test-case
                (symbol->string 'target)
                target))))

(define main
    (lambda (_)
        (test-start "intersperse")
        (labelled-test test-intersperse intersperse/fold)
        (labelled-test test-intersperse intersperse/tailrec)
        (test-end)))

(define test-intersperse
    (lambda (label intersperse)
        (test-section label)
        (test* "#1" '() (intersperse 'x '()))
        (test* "#2" '(a) (intersperse 'x '(a)))
        (test* "#3" '(a x b) (intersperse 'x '(a b)))
        (test* "#4" '(a x b x c) (intersperse 'x '(a b c)))
        (test* "#5" '(a _ b _ c) (intersperse '_ '(a b c)))))

