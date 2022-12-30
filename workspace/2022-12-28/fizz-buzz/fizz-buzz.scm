
;
; 1 以上 n 以下の Fizz-Buzz を求める.
;
(define fizz-buzz
    (lambda (n)
        (map
            fizz-buzz-value
            (iota n 1))))

;
; i 番目の Fizz-Buzz の値を求める.
;
(define fizz-buzz-value
    (lambda (i)
        (cond
            ((< i 0)
                #f)
            ((= (modulo i 15) 0)
                'FizzBuzz)
            ((= (modulo i 5) 0)
                'Buzz)
            ((= (modulo i 3) 0)
                'Fizz)
            (else
                i))))

