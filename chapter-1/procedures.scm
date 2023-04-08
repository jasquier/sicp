; Note that you can have as many expressions
; as you want in the body of a procedure.
(define (two-expressions)
  (+ 2 2)
  (+ 1 1))

; Computes the absolute value of a number.
(define (abs x) (if (< x 0) (- x) x))
