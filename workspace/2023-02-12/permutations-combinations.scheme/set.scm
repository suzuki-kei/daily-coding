
(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            ((equal? x (car xs))
                #t)
            (else
                (include? x (cdr xs))))))

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
            (error "set1 is not set"))
        (if (not (set? set2))
            (error "set2 is not set"))
        (and
            (subset? set1 set2)
            (subset? set2 set1))))

