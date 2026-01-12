
(define main
    (lambda (_)
        (demonstration)
        0))

(define demonstration
    (lambda ()
        (for-each
            (lambda (n)
                (for-each
                    (lambda (r)
                        (print-combination n r))
                    (iota (+ n 1))))
            (iota 7))))

(define print-combination
    (lambda (n r)
        (let ((c (combination n r)))
            (print
                (format "C(n=~a, r=~a) = ~a" n r c)))))

; C(n, r)   = n! / (r! * (n-r)!)
; C(n, r-1) = n! / ((r-1)! * (n-(r-1))!)
; r!        = r * (r-1)!
; (n-r)!    = (n-(r-1))! / (n-(r-1))
; C(n, r)   = C(n, r-1) * (n-(r-1)) / r
(define combination
    (lambda (n r)
        (cond
            ((or (= n 0) (= r 0) (= n r))
                1)
            (else
                (/
                    (*
                        (combination
                            n
                            (- r 1))
                        (-
                            n
                            (- r 1)))
                    r)))))

