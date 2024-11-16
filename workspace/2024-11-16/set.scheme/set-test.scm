(use gauche.test)
(load "set")

(define main
    (lambda (_)
        (test-start "set")
        (test-include?)
        (test-set?)
        (test-set-equal?)
        (test-list->set)
        (test-set-union)
        (test-set-difference)
        (test-set-intersection)
        (test-end)))

(define-syntax parameterized-test
    (syntax-rules ()
        ((_ procedure tuples)
            (parameterized-test procedure equal? tuples))
        ((_ procedure check tuples)
            (begin
                (test-section (x->string 'procedure))
                (for-each
                    (lambda (tuple index)
                        (test*
                            (format "#~d" (+ index 1))
                            (car tuple)
                            (apply procedure (cdr tuple))
                            check))
                    tuples
                    (iota (length tuples)))))))

(define-syntax define-parameterized-test
    (syntax-rules ()
        ((_ procedure tuples)
            (define-parameterized-test procedure equal? tuples))
        ((_ procedure check tuples)
            (eval
                `(define
                    ,(string->symbol (format "test-~a" 'procedure))
                    (lambda ()
                        (parameterized-test procedure check tuples)))
                null-environment))))

(define-parameterized-test include? '(
    (#f a ())
    (#t a (a))
    (#f b (a))
    (#t a (a b c))
    (#t b (a b c))
    (#t c (a b c))
    (#f d (a b c))))

(define-parameterized-test set? '(
    (#t ())
    (#t (a))
    (#t (a b))
    (#t (b a))
    (#f (a a))
    (#t (a b c))
    (#t (b c a))
    (#t (c a b))
    (#f (a a b))
    (#f (a b b))
    (#f (a b a))))

(define-parameterized-test set-equal? '(
    (#t ()      ())
    (#t (a)     (a))
    (#f (a)     (b))
    (#f (b)     (a))
    (#t (a b)   (a b))
    (#t (a b)   (b a))
    (#f (a b)   (a a))
    (#f (a b)   (b b))
    (#t (a b c) (a b c))
    (#t (a b c) (b c a))
    (#t (a b c) (c a b))
    (#f (a b c) (a b d))
    (#f (a b c) (a d c))
    (#f (a b c) (d b c))))

(define-parameterized-test list->set set-equal? '(
    (()      ())
    ((a)     (a))
    ((a)     (a a))
    ((a b)   (a b))
    ((a)     (a a a))
    ((a b)   (a b a))
    ((a b c) (a b c))))

(define-parameterized-test set-union set-equal? '(
    (()          ()      ())
    ((a)         (a)     (a))
    ((a b)       (a)     (b))
    ((a b)       (b)     (a))
    ((a b c d e) (a b c) (c d e))))

(define-parameterized-test set-difference set-equal? '(
    (()      ()          ())
    (()      ()          (a))
    (()      (a)         (a))
    ((a)     (a)         (b))
    ((a c e) (a b c d e) (b d))))

(define-parameterized-test set-intersection set-equal? '(
    (()      ()  ())
    (()      (a) ())
    (()      ()  (a))
    (()      (a c e) (b d))
    ((b c d) (a b c d) (b c d e))))

