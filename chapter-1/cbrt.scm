; Finds the cube root of x using an iterative process.
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (define tolerance (* (expt 2 -52) x))
  (define next-guess (improve guess x))
  (or (= guess 0) (< (abs (- guess next-guess)) tolerance)))

(define (cbrt x)
  (cbrt-iter 1.0 x))
