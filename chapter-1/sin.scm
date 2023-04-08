; Code from Exercise 1.15 modifed to help solve the exercise.
(define (cube x) (* x x x))

(define (p x)
  (display "p")
  (newline)
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))
