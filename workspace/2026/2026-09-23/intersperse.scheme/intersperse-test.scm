(use gauche.test)
(load "intersperse")

(define-syntax test/case
    (syntax-rules ()
        ((_ test-case target)
            (test-case
                (symbol->string 'target)
                target))))

(define main
    (lambda (_)
        (test-start "intersperse")
        (test/case test-intersperse intersperse/fold)
        (test/case test-intersperse intersperse/tailrec)
        (test-end)))

(define test-intersperse
    (lambda (label intersperse)
        (test-section label)
        (test* "#1" '() (intersperse '_ '()))
        (test* "#2" '(a) (intersperse '_ '(a)))
        (test* "#3" '(a _ b) (intersperse '_ '(a b)))
        (test* "#4" '(a _ b _ c) (intersperse '_ '(a b c)))
        (test* "#5" '(a x b x c) (intersperse 'x '(a b c)))))

