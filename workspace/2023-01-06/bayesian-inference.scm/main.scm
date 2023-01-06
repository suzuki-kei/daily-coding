
(define probability-alist '(
    (liar-say-lie     . 0.8)    ; 嘘つきが嘘を言う確率.
    (liar-say-truth   . 0.2)    ; 嘘つきが本当のことを言う確率.
    (honest-say-lie   . 0.1)    ; 正直者が嘘を言う確率.
    (honest-say-truth . 0.9)    ; 正直者が本当のことを言う確率.
))

(define main
    (lambda (arguments)
        (simulate '())
        (simulate '(#f))
        (simulate '(#f #f))
        (simulate '(#f #f #f))
        (simulate '(#t))
        (simulate '(#t #t))
        (simulate '(#t #t #t))
        (simulate '(#t #f #t))
        (simulate '(#f #t #f))
        0))

(define assoc-value
    (lambda (key alist)
        (cdr (assoc key alist))))

(define simulate
    (lambda (say-flags)
        (let* ((person (person.new 0.5 0.5))
               (updated-person (updates person say-flags)))
            (print
                (format
                    "~a : ~a"
                    (person.format updated-person)
                    say-flags)))))

(define updates
    (lambda (person say-flags)
        (fold
            (lambda (say-flag person)
                (person.say person say-flag))
            person
            say-flags)))

(define person.new
    (lambda (liar-probability honest-probability)
        (list
            `(liar-probability   . ,liar-probability)
            `(honest-probability . ,honest-probability))))

(define person.format
    (lambda (person)
        (format
            "liar=~,2f, honest=~,2f"
            (assoc-value 'liar-probability person)
            (assoc-value 'honest-probability person))))

(define person.say
    (lambda (person say-flag)
        (if say-flag
            (person.say-truth person)
            (person.say-lie person))))

(define person.say-lie
    (lambda (person)
        (let (
            ; この人が嘘つき, かつ, 嘘を言った確率.
            (p1 (* (assoc-value 'liar-probability person)
                   (assoc-value 'liar-say-lie probability-alist)))
            ; この人が正直者, かつ, 嘘を言った確率.
            (p2 (* (assoc-value 'honest-probability person)
                   (assoc-value 'honest-say-lie probability-alist))))
            (person.new
                (/ p1 (+ p1 p2))
                (/ p2 (+ p1 p2))))))

(define person.say-truth
    (lambda (person)
        (let (
            ; この人が嘘つき, かつ, 正しいことを言った確率.
            (p1 (* (assoc-value 'liar-probability person)
                   (assoc-value 'liar-say-truth probability-alist)))
            ; この人が正直者, かつ, 正しいことを言った確率.
            (p2 (* (assoc-value 'honest-probability person)
                   (assoc-value 'honest-say-truth probability-alist))))
            (person.new
                (/ p1 (+ p1 p2))
                (/ p2 (+ p1 p2))))))

