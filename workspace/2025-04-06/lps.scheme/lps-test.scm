(load "lps")
(use gauche.test)

(define main
    (lambda (_)
        (test-start "lps")
        (test-prefixes)
        (test-proper-prefixes)
        (test-suffixes)
        (test-proper-suffixes)
        (test-lps)
        (test-lps-array)
        (test-end)))

(define test-prefixes
    (lambda ()
        (test-section "prefixes")
        (test* "#1" '(()) (prefixes '()))
        (test* "#2" '(() (a)) (prefixes '(a)))
        (test* "#3" '(() (a) (a b)) (prefixes '(a b)))
        (test* "#4" '(() (a) (a b) (a b c)) (prefixes '(a b c)))))

(define test-proper-prefixes
    (lambda ()
        (test-section "proper-prefixes")
        (test* "#1" '() (proper-prefixes '()))
        (test* "#2" '(()) (proper-prefixes '(a)))
        (test* "#3" '(() (a)) (proper-prefixes '(a b)))
        (test* "#4" '(() (a) (a b)) (proper-prefixes '(a b c)))))

(define test-suffixes
    (lambda ()
        (test-section "suffixes")
        (test* "#1" '(()) (suffixes '()))
        (test* "#2" '(() (a)) (suffixes '(a)))
        (test* "#3" '(() (b) (a b)) (suffixes '(a b)))
        (test* "#4" '(() (c) (b c) (a b c)) (suffixes '(a b c)))))

(define test-proper-suffixes
    (lambda ()
        (test-section "proper-suffixes")
        (test* "#1" '() (proper-suffixes '()))
        (test* "#2" '(()) (proper-suffixes '(a)))
        (test* "#3" '(() (b)) (proper-suffixes '(a b)))
        (test* "#4" '(() (c) (b c)) (proper-suffixes '(a b c)))))

(define test-lps
    (lambda ()
        (test-section "lps")
        (test* "#1" '() (lps '()))
        (test* "#2" '() (lps '(a)))
        (test* "#3" '(a) (lps '(a a)))
        (test* "#4" '(a a) (lps '(a a a)))
        (test* "#5" '() (lps '(a b)))
        (test* "#6" '(a) (lps '(a b a)))
        (test* "#7" '(a b) (lps '(a b a b)))
        (test* "#8" '(a b a) (lps '(a b a b a)))
        (test* "#9" '(a b a b) (lps '(a b a b a b)))
        (test* "#10" '() (lps '(a b c)))
        (test* "#11" '(a) (lps '(a b c a)))
        (test* "#12" '(a b) (lps '(a b c a b)))
        (test* "#13" '(a b c) (lps '(a b c a b c)))
        (test* "#14" '(a b c a) (lps '(a b c a b c a)))
        (test* "#15" '(a b c a b) (lps '(a b c a b c a b)))
        (test* "#16" '(a b c a b c) (lps '(a b c a b c a b c)))
        (test* "#17" '() (lps '(a b c a b c a b c d)))))

(define test-lps-array
    (lambda ()
        (test-section "lps-array")
        (test* "#1" '() (lps-array '()))
        (test* "#2" '(0) (lps-array '(a)))
        (test* "#3" '(0 1) (lps-array '(a a)))
        (test* "#4" '(0 1 2) (lps-array '(a a a)))
        (test* "#5" '(0 0) (lps-array '(a b)))
        (test* "#6" '(0 0 1) (lps-array '(a b a)))
        (test* "#7" '(0 0 1 2) (lps-array '(a b a b)))
        (test* "#8" '(0 0 1 2 3) (lps-array '(a b a b a)))
        (test* "#9" '(0 0 1 2 3 4) (lps-array '(a b a b a b)))
        (test* "#10" '(0 0 0) (lps-array '(a b c)))
        (test* "#11" '(0 0 0 1) (lps-array '(a b c a)))
        (test* "#12" '(0 0 0 1 2) (lps-array '(a b c a b)))
        (test* "#13" '(0 0 0 1 2 3) (lps-array '(a b c a b c)))
        (test* "#14" '(0 0 0 1 2 3 4) (lps-array '(a b c a b c a)))
        (test* "#15" '(0 0 0 1 2 3 4 5) (lps-array '(a b c a b c a b)))
        (test* "#16" '(0 0 0 1 2 3 4 5 6) (lps-array '(a b c a b c a b c)))
        (test* "#17" '(0 0 0 1 2 3 4 5 6 0) (lps-array '(a b c a b c a b c d)))))

