
(define main
    (lambda (_)
        (demonstration1)
        (demonstration2)
        0))

(define demonstration1
    (lambda ()
        (print "==== demonstration1")
        (for-each
            (lambda (n)
                (for-each
                    (lambda (r)
                        (print-combination n r))
                    (iota (+ n 1))))
            (iota (+ 6 1)))))

(define demonstration2
    (lambda ()
        (print "==== demonstration2")
        (print "Q. 袋の中に赤玉 3 個, 白玉 2 個, 黒玉 1 個が入っている.")
        (print "同時に 3 個取り出すとき, 赤玉が 2 個, 白玉が 1 個となる確率を求めよ.")
        (print
            (format
                "A. C(3, 2) * C(2, 1) / C(6, 3) = ~d * ~d / ~d = ~d"
                (combination 3 2)
                (combination 2 1)
                (combination 6 3)
                (/ (* (combination 3 2) (combination 2 1)) (combination 6 3))))))

(define print-combination
    (lambda (n r)
        (let ((c (combination n r)))
            (print
                (format "C(n=~d, r=~d) = ~d" n r c)))))

;
; n 個の中から r 個選ぶ組み合わせの数を求める.
;
; C(n, r)   = n! / (r! * (n-r)!)
; C(n, r-1) = n! / ((r-1)! * (n-r+1)!)
; C(n, r)   = C(n, r-1) * (n-r+1) / r
;
(define combination
    (lambda (n r)
        (cond
            ((= n 0)
                1)
            ((= r 0)
                1)
            ((= n r)
                1)
            (else
                (*
                    (combination
                        n
                        (- r 1))
                    (/
                        (- n (- r 1))
                        r))))))

