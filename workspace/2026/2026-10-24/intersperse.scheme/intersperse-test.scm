(load "intersperse")
(use gauche.test)

(define-syntax test/case
    (syntax-rules ()
        ((_ test-case target)
            (begin
                (print "==== " (symbol->string 'target))
                (test-case target)))))

(define main
    (lambda (_)
        (test-start "intersperse")
        (test/case test-intersperse intersperse/fold)
        (test/case test-intersperse intersperse/tailrec)
        (test-end)))

(define test-intersperse
    (lambda (intersperse)
        (test* "#1" '() (intersperse '_ '()))
        (test* "#2" '(a) (intersperse '_ '(a)))
        (test* "#3" '(a _ b) (intersperse '_ '(a b)))
        (test* "#4" '(a _ b _ c) (intersperse '_ '(a b c)))
        (test* "#5" '(a x b x c) (intersperse 'x '(a b c)))))

