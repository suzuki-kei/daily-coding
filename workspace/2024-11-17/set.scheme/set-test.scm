(use gauche.test)
(load "set")

(define main
    (lambda (_)
        (test-start "set")
        (test-include?)
        (test-set?)
        (test-set-equal?)
        (test-list->set)
        (test-union)
        (test-difference)
        (test-intersection)
        (test-end)))

(define-syntax parameterized-test
    (syntax-rules ()
        ((_ procedure tuples)
            (parameterized-test procedure equal? tuples))
        ((_ procedure check tuples)
            (for-each
                (lambda (tuple index)
                    (test*
                        (format "#~a" (+ index 1))
                        (car tuple)
                        (apply procedure (cdr tuple))
                        check))
                tuples
                (iota (length tuples))))))

(define-syntax define-parameterized-test
    (syntax-rules ()
        ((_ procedure tuples)
            (define-parameterized-test procedure equal? tuples))
        ((_ procedure check tuples)
            (eval
                `(define
                    ,(string->symbol (format "test-~a" 'procedure))
                    (lambda ()
                        (test-section (format "~a" 'procedure))
                        (parameterized-test procedure check tuples)))
                null-environment))))

(define-parameterized-test include? '(
    (#f a ())
    (#t a (a))
    (#f b (a))
    (#t a (a b))
    (#t b (a b))
    (#f c (a b))
    (#t a (a b c))
    (#t b (a b c))
    (#t c (a b c))
    (#f d (a b c))))

(define-parameterized-test set? '(
    (#t ())
    (#t (a))
    (#f (a a))
    (#t (a b))
    (#t (b a))
    (#f (b b))
    (#f (a a a))
    (#f (a a b))
    (#f (a b a))
    (#f (a b b))
    (#t (a b c))
    (#t (c b a))))

(define-parameterized-test set-equal? '(
    (#t () ())
    (#f () (a))
    (#f (a) ())
    (#t (a) (a))
    (#f (a) (b))
    (#f (b) (a))
    (#t (a b c) (a b c))
    (#t (a b c) (c b a))
    (#f (a b c) (a b c d))
    (#f (a b c d) (a b c))
    (#t (a c b d e) (b d a e c))
    (#t (a c b d e) (b d a e c))))

(define-parameterized-test list->set set-equal? '(
    (() ())
    ((a) (a))
    ((a) (a a))
    ((a b) (a b))
    ((a) (a a a))
    ((a b) (a b a))
    ((a b c) (a b c))))

(define-parameterized-test union set-equal? '(
    (() () ())
    ((a) (a) ())
    ((a) () (a))
    ((a) (a) (a))
    ((a b) (a) (b))
    ((a b c d e) (a b c) (c d e))
    ((a b c d e f) (a b c) (d e f))))

(define-parameterized-test difference set-equal? '(
    (() () ())
    (() () (a))
    ((a) (a) ())
    (() (a) (a))
    ((a b) (a b) ())
    ((a) (a b) (b))
    (() (a b) (a b))
    ((a b c) (a b c) ())
    ((a b) (a b c) (c))
    ((a) (a b c) (b c))
    (() (a b c) (a b c))))

(define-parameterized-test intersection set-equal? '(
    (() () ())
    ((a) (a) (a))
    (() (a) ())
    (() () (a))
    ((a b) (a b) (a b))
    ((a) (a b) (a))
    ((b) (a b) (b))
    ((a) (a) (a b))
    ((b) (b) (a b))
    ((b d) (a b c d e) (b d))))

