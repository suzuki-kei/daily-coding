
(define test.parameterized
    (lambda (tuples callback)
        (test.parameterized.tailrec callback tuples 0)))

(define test.parameterized.tailrec
    (lambda (callback tuples index)
        (cond
            ((null? tuples)
                #f)
            (else
                (apply
                    callback
                    (cons index (car tuples)))
                (test.parameterized.tailrec
                    callback
                    (cdr tuples)
                    (+ index 1))))))

