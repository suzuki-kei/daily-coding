
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

(define set-equal?
    (lambda (set1 set2)
        (and
            (every
                (lambda (x)
                    (include? x set2))
                set1)
            (every
                (lambda (x)
                    (include? x set1))
                set2))))

(define list->set
    (lambda (xs :optional (set '()))
        (cond
            ((null? xs)
                set)
            ((include? (car xs) set)
                (list->set
                    (cdr xs)
                    set))
            (else
                (list->set
                    (cdr xs)
                    (cons (car xs) set))))))

(define union
    (lambda (set1 set2)
        (cond
            ((null? set1)
                set2)
            ((include? (car set1) set2)
                (union
                    (cdr set1)
                    set2))
            (else
                (union
                    (cdr set1)
                    (cons (car set1) set2))))))

(define difference
    (lambda (set1 set2)
        (filter
            (lambda (x)
                (not (include? x set2)))
            set1)))

(define intersection
    (lambda (set1 set2)
        (filter
            (lambda (x)
                (include? x set2))
            set1)))

