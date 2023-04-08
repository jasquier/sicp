(define (sqrt-iter guess x)
  (if (good-enough-2? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (good-enough-2? guess x)
  (define tolerance (* (expt 2 -52) x))
  (define next-guess (improve guess x))
  (or (= guess 0) (< (abs (- guess next-guess)) tolerance)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
