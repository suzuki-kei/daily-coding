(use gauche.test)
(load "flatten")

(define-syntax labelled-test
    (syntax-rules ()
        ((_ test-case target)
            (test-case
                (symbol->string 'target)
                target))))

(define main
    (lambda (_)
        (test-start "flatten")
        (labelled-test test-flatten flatten/tailrec)
        (labelled-test test-flatten flatten/non-tailrec)
        (test-end)))

(define test-flatten
    (lambda (label flatten)
        (test-section label)
        (test* "#1" '() (flatten '()))
        (test* "#2" '() (flatten '(())))
        (test* "#3" '() (flatten '((()))))
        (test* "#4" '() (flatten '(((())))))
        (test* "#5" '() (flatten '(() ())))
        (test* "#6" '() (flatten '(() () ())))
        (test* "#7" '(a) (flatten '(a)))
        (test* "#8" '(a b) (flatten '(a (b))))
        (test* "#9" '(a b c) (flatten '(a (b) ((c)))))
        (test* "#10" '(a b c d) (flatten '(a (b) ((c d)))))
        (test* "#11" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test* "#12" '(a) (flatten '((a))))
        (test* "#13" '(a b) (flatten '((a (b)))))
        (test* "#14" '(a b c) (flatten '((a (b c)))))
        (test* "#15" '(a b c d) (flatten '((a (b c)) (d))))
        (test* "#16" '(a b c d e) (flatten '((a (b c)) (d) e)))))

