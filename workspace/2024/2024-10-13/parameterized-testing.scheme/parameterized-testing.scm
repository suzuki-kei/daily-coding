
(define for-each-with-index
    (lambda (callback xs)
        (for-each
            (lambda (x offset)
                (let* ((index (+ offset 1))
                       (arguments (list index x)))
                    (apply callback arguments)))
            xs
            (iota (length xs)))))

(define-syntax parameterized-test
    (syntax-rules ()
        ((_ procedure expedted-argument-pairs)
            (for-each-with-index
                (lambda (index pair)
                    (let* ((name (format "~a #~a" 'procedure index))
                           (expected (car pair))
                           (arguments (cadr pair))
                           (actual (apply procedure arguments)))
                        (test* name expected actual)))
                expedted-argument-pairs))))

(define-syntax make-parameterized-test
    (syntax-rules ()
        ((_ procedure expedted-arguments-pairs)
            (lambda ()
                (test-section (x->string 'procedure))
                (parameterized-test procedure expedted-arguments-pairs)))))

(define-syntax define-parameterized-test
    (syntax-rules ()
        ((_ procedure tuples)
            (let ((name (string->symbol (format "test-~a" 'procedure))))
                (eval
                    `(define
                        ,name
                        (make-parameterized-test procedure tuples))
                    null-environment)))))

