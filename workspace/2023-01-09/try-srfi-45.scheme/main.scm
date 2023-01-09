(use srfi-45)

(print "==== delay =====================================================")

(define delay-promise
    (delay
        (let ()
            (print "called")
            (+ 1 2))))

; プロミスの値が評価されて "called" が出力される.
; その後, force が評価結果として返した 3 が出力される.
(print (force delay-promise))

; プロセスの値は評価済みのため "called" は出力されない.
(print (force delay-promise))

(print "==== eager =====================================================")

(define eager-promise
    ; 先行評価されるため "called" が出力される.
    (eager
        (let ()
            (print "called")
            (+ 1 2))))

; プロセスの値は評価済みのため "called" は出力されない.
(print (force eager-promise))
(print (force eager-promise))

