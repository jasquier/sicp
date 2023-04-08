; Recursive process from Exercise 1.11
(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1))
         (* 2 (f1 (- n 2)))
         (* 3 (f1 (- n 3))))))

(define (f2 n)
  (f-iter 0 1 2 n))

(define (f-iter a b c count)
  (display a)
  (display " ")
  (display b)
  (display " ")
  (display c)
  (display " ")
  (display count)
  (newline)
  (if (= count 0)
      a
      (f-iter b
              c
              (+ (* 3 a) (* 2 b) c)
              (- count 1))))
