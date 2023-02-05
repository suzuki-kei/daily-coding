
(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            ((equal? x (car xs))
                #t)
            (else
                (include? x (cdr xs))))))

(define list->set
    (lambda (xs)
        (list->set.tailrec '() xs)))

(define list->set.tailrec
    (lambda (set xs)
        (cond
            ((null? xs)
                set)
            ((include? (car xs) set)
                (list->set.tailrec
                    set
                    (cdr xs)))
            (else
                (list->set.tailrec
                    (cons (car xs) set)
                    (cdr xs))))))

(define set?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((include? (car xs) (cdr xs))
                #f)
            (else
                (set? (cdr xs))))))

(define set-include?
    (lambda (set1 set2)
        (every
            (lambda (x)
                (include? x set2))
            set1)))

(define set-equal?
    (lambda (set1 set2)
        (and
            (set-include? set1 set2)
            (set-include? set2 set1))))

(define set-union
    (lambda (set1 set2)
        (set-union.tailrec '() set1 set2)))

(define set-union.tailrec
    (lambda (union set1 set2)
        (cond
            ((null? set1)
                (append set2 union))
            ((null? set2)
                (append set1 union))
            ((include? (car set1) set2)
                (set-union.tailrec
                    union
                    (cdr set1)
                    set2))
            (else
                (set-union.tailrec
                    (cons (car set1) union)
                    (cdr set1)
                    set2)))))

(define set-difference
    (lambda (set1 set2)
        (set-difference.tailrec '() set1 set2)))

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
        (set-intersection.tailrec '() set1 set2)))

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

