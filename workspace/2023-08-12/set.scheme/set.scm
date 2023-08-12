
;
; リスト xs に x が含まれることを判定する.
;
(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            ((equal? x (car xs))
                #t)
            (else
                (include? x (cdr xs))))))

;
; リスト xs が集合であることを判定する.
;
(define set?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((include? (car xs) (cdr xs))
                #f)
            (else
                (set? (cdr xs))))))

;
; set2 が set1 の部分集合であることを判定する.
;
(define subset?
    (lambda (set1 set2)
        (cond
            ((null? set2)
                #t)
            (else
                (and
                    (include? (car set2) set1)
                    (subset? set1 (cdr set2)))))))

;
; set1 と set2 が等しいことを判定する.
;
(define set-equal?
    (lambda (set1 set2)
        (and
            (subset? set1 set2)
            (subset? set2 set1))))

;
; リスト xs から集合を作成する.
;
(define make-set
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((include? (car xs) (cdr xs))
                (make-set (cdr xs)))
            (else
                (cons
                    (car xs)
                    (make-set (cdr xs)))))))

;
; set1 と set2 の和集合を求める.
;
(define set-union
    (lambda (set1 set2)
        (cond
            ((null? set1)
                set2)
            ((include? (car set1) set2)
                (set-union (cdr set1) set2))
            (else
                (cons
                    (car set1)
                    (set-union (cdr set1) set2))))))

;
; set1 と set2 の差集合 (set1 - set2) を求める.
;
(define set-difference
    (lambda (set1 set2)
        (cond
            ((null? set1)
                '())
            ((include? (car set1) set2)
                (set-difference (cdr set1) set2))
            (else
                (cons
                    (car set1)
                    (set-difference (cdr set1) set2))))))

;
; set1 と set2 の共通部分を求める.
;
(define set-intersection
    (lambda (set1 set2)
        (cond
            ((null? set1)
                '())
            ((include? (car set1) set2)
                (cons
                    (car set1)
                    (set-intersection (cdr set1) set2)))
            (else
                (set-intersection (cdr set1) set2)))))

