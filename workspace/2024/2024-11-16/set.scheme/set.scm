
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

(define set-union
    (lambda (set1 set2)
        (list->set
            (append set1 set2))))

(define set-difference
    (lambda (set1 set2 :optional (accumulated '()))
        (cond
            ((null? set1)
                accumulated)
            ((include? (car set1) set2)
                (set-difference
                    (cdr set1)
                    set2
                    accumulated))
            (else
                (set-difference
                    (cdr set1)
                    set2
                    (cons (car set1) accumulated))))))

(define set-intersection
    (lambda (set1 set2)
        (filter
            (lambda (x)
                (include? x set2))
            set1)))

