
; 嘘つきが嘘を言う確率.
(define liar-say-lie-probability 0.8)

; 嘘つきが本当のことを言う確率.
(define liar-say-truth-probability
    (- 1 liar-say-lie-probability))

; 正直者が嘘を言う確率.
(define honest-say-lie-probability 0.1)

; 正直者が本当のことを言う確率.
(define honest-say-truth-probability
    (- 1 honest-say-lie-probability))

(define assoc-value
    (lambda (key alist)
        (let ((pair (assoc key alist)))
            (cond
                ((pair? pair)
                    (cdr pair))
                (else
                    pair)))))

(define simulate
    (lambda (person say-flags)
        (fold
            (lambda (say-flag person)
                (person.say person say-flag))
            person
            say-flags)))

(define person.new
    (lambda (honest-probability)
        (let
            ((liar-probability (- 1 honest-probability)))
            (list
                (cons 'liar-probability liar-probability)
                (cons 'honest-probability honest-probability)))))

(define person.print
    (lambda (person)
        (print
            (person.format person))))

(define person.format
    (lambda (person)
        (format
            "(liar=~,2f, honest=~,2f)"
            (person.liar-probability person)
            (person.honest-probability person))))

(define person.liar-probability
    (lambda (person)
        (assoc-value 'liar-probability person)))

(define person.honest-probability
    (lambda (person)
        (assoc-value 'honest-probability person)))

(define person.say
    (lambda (person truth)
        (if
            truth
            (person.say-truth person)
            (person.say-lie person))))

(define person.say-lie
    (lambda (person)
        (let* (
            ; この人が嘘つき, かつ嘘を言った確率.
            (p1 (* (person.liar-probability person)
                   liar-say-lie-probability))
            ; この人が正直者, かつ嘘を言った確率.
            (p2 (* (person.honest-probability person)
                   honest-say-lie-probability))
            (new-honest-probability
                (/ p2 (+ p1 p2))))
            (person.new new-honest-probability))))

(define person.say-truth
    (lambda (person)
        (let* (
            ; この人が嘘つき, かつ本当のことを言った確率.
            (p1 (* (person.liar-probability person)
                   liar-say-truth-probability))
            ; この人が正直者, かつ本当のことを言った確率.
            (p2 (* (person.honest-probability person)
                    honest-say-truth-probability))
            (new-honest-probability
                (/ p2 (+ p1 p2))))
            (person.new new-honest-probability))))

