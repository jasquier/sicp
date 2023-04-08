; Answer for Exercise 1.29 Simpson's rule for integration.

(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))

  (* (sum f (+ a (/ dx 2.0)) add-dx b)
  dx))

(define (simpson f a b n)
  (define h (/ (- b a) n))

  (define (ahh-2h x) (+ x h h))

  (* (+ (f a)
        (* 2 (sum f a add-2h b))
        (* 4 (sum f (+ a h) add-2h b))
        (f b))
     (/ h 3)))
