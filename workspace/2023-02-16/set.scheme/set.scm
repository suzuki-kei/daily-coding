
(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            ((equal? (car xs) x)
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
        (cond
            ((not (set? set1))
                (error "set1 is not set"))
            ((not (set? set2))
                (error "set2 is not set"))
            (else
                (and
                    (subset? set1 set2)
                    (subset? set2 set1))))))

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

(define set-union
    (lambda (set1 set2)
        (set-union.tailrec
            set1 set2)))

(define set-union.tailrec
    (lambda (union set)
        (cond
            ((null? set)
                union)
            ((include? (car set) union)
                (set-union.tailrec
                    union
                    (cdr set)))
            (else
                (set-union.tailrec
                    (cons (car set) union)
                    (cdr set))))))

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

