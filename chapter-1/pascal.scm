; Computes an element of Pascal's triangle for Exercise 1.12
; The top of the triangle is 0 0 and col can not be greater than row.
(define (pascal row col)
  (if (is-edge? row col)
      1
      (+ (pascal (- row 1) col)
         (pascal (- row 1) (- col 1)))))

(define (is-edge? row col)
  (cond ((= col 0) #true)
        ((= col row) #true)
        (else #false)))
