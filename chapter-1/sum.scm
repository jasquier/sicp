; Solution for Exercise 1.30

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (identity x) x)

(define (inc x) (+ x 1))

(define (sum-integers a b)
  (sum identity a inc b))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))
