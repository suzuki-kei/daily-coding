
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

(define set-equal?
    (lambda (set1 set2)
        (and
            (every (lambda (x) (include? x set2)) set1)
            (every (lambda (x) (include? x set1)) set2))))

(define xs->set
    (lambda (xs)
        (xs->set.tailrec '() xs)))

(define xs->set.tailrec
    (lambda (set xs)
        (cond
            ((null? xs)
                set)
            ((include? (car xs) (cdr xs))
                (xs->set.tailrec
                    set
                    (cdr xs)))
            (else
                (xs->set.tailrec
                    (cons (car xs) set)
                    (cdr xs))))))

(define set-union
    (lambda (set1 set2)
        (cond
            ((null? set2)
                set1)
            ((include? (car set2) set1)
                (set-union
                    set1
                    (cdr set2)))
            (else
                (set-union
                    (cons (car set2) set1)
                    (cdr set2))))))

(define set-difference
    (lambda (set1 set2)
        (set-difference.tailrec
            '() set1 set2)))

(define set-difference.tailrec
    (lambda (difference set1 set2)
        (cond
            ((null? set1)
                difference)
            ((include? (car set1) set2)
                (set-difference.tailrec
                    difference
                    (cdr set1)
                    set2))
            (else
                (set-difference.tailrec
                    (cons (car set1) difference)
                    (cdr set1)
                    set2)))))

(define set-intersection
    (lambda (set1 set2)
        (set-intersection.tailrec
            '() set1 set2)))

(define set-intersection.tailrec
    (lambda (intersection set1 set2)
        (cond
            ((null? set1)
                intersection)
            ((include? (car set1) set2)
                (set-intersection.tailrec
                    (cons (car set1) intersection)
                    (cdr set1)
                    set2))
            (else
                (set-intersection.tailrec
                    intersection
                    (cdr set1)
                    set2)))))

