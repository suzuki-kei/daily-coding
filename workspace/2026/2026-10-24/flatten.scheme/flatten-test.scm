(load "flatten")
(use gauche.test)

(define-syntax test/case
    (syntax-rules ()
        ((_ test-case target)
            (begin
                (print "==== " 'target)
                (test-case target)))))

(define main
    (lambda (_)
        (test-start "flatten")
        (test/case test-flatten flatten/tailrec)
        (test/case test-flatten flatten/non-tailrec)
        (test-end)))

(define test-flatten
    (lambda (flatten)
        (test* "#1" '() (flatten '()))
        (test* "#2" '() (flatten '(())))
        (test* "#3" '() (flatten '((()))))
        (test* "#4" '() (flatten '(((())))))
        (test* "#5" '() (flatten '(() ())))
        (test* "#6" '() (flatten '(() () ())))
        (test* "#7" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test* "#8" '(a b c d e) (flatten '((a (b c)) (d) e)))))

