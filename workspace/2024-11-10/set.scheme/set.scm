
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
    (lambda (s1 s2)
        (every
            (lambda (x)
                (include? x s2))
            s1)))

(define list->set
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((include? (car xs) (cdr xs))
                (list->set (cdr xs)))
            (else
                (cons
                    (car xs)
                    (list->set (cdr xs)))))))

(define set-equal?
    (lambda (s1 s2)
        (and
            (every
                (lambda (x)
                    (include? x s2))
                s1)
            (every
                (lambda (x)
                    (include? x s1))
                s2))))

(define union
    (lambda (s1 s2)
        (list->set
            (append s1 s2))))

(define difference
    (lambda (s1 s2)
        (filter
            (lambda (x)
                (not (include? x s2)))
            s1)))

(define intersection
    (lambda (s1 s2)
        (filter
            (lambda (x)
                (include? x s2))
            s1)))

