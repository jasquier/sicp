; Solution to Exercise 1.16
(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter base exponent acc)
  (display base)
  (display " ")
  (display exponent)
  (display " ")
  (display acc)
  (newline)
  (cond ((= exponent 0) acc)
        ((even? exponent) (fast-expt-iter base
                                          (/ exponent 2)
                                          (* (fast-expt base (/ exponent 2))
                                             acc)))
        (else (fast-expt-iter base
                              (- exponent 1)
                              (* base acc)))))
