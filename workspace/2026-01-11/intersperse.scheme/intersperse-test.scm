(use gauche.test)
(load "intersperse.scm")

(define-syntax my-test
    (syntax-rules ()
        ((_ test-case f)
            (test-case (symbol->string 'f) f))))

(define main
    (lambda (_)
        (test-start "intersperse")
        (my-test test-intersperse intersperse.fold)
        (my-test test-intersperse intersperse.recursive)
        (test-end)))

(define test-intersperse
    (lambda (label intersperse)
        (test-section label)
        (test* "#1" '() (intersperse 'x '()))
        (test* "#2" '(a) (intersperse 'x '(a)))
        (test* "#3" '(a x b) (intersperse 'x '(a b)))
        (test* "#4" '(a x b x c) (intersperse 'x '(a b c)))
        (test* "#5" '(a _ b _ c) (intersperse '_ '(a b c)))))

