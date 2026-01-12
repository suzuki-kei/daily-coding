
(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            (else
                (or
                    (equal? x (car xs))
                    (include? x (cdr xs)))))))

(define set?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((include? (car xs) (cdr xs))
                #f)
            (else
                (set? (cdr xs))))))

(define subset?
    (lambda (set1 set2)
        (cond
            ((null? set1)
                #t)
            (else
                (and
                    (include? (car set1) set2)
                    (subset? (cdr set1) set2))))))

(define set-equal?
    (lambda (set1 set2)
        (if (not (set? set1))
            (error (format "set1 is not set: ~a" set1)))
        (if (not (set? set2))
            (error (format "set2 is not set: ~a" set2)))
        (and
            (subset? set1 set2)
            (subset? set2 set1))))

(define xs->set
    (lambda (xs)
        (xs->set.tailrec
            '() xs)))

(define xs->set.tailrec
    (lambda (set xs)
        (cond
            ((null? xs)
                set)
            ((include? (car xs) set)
                (xs->set.tailrec
                    set
                    (cdr xs)))
            (else
                (xs->set.tailrec
                    (cons (car xs) set)
                    (cdr xs))))))

