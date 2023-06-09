; Code for Exercise 1.22
(define (search-for-primes start end)
  (cond ((> start end) false)
        (else (timed-prime-test (first-odd-after start))
              (search-for-primes (+ (first-odd-after start) 2) end))))

(define (first-odd-after x)
  (if (even? x)
      (+ x 1)
      x))

(define (even? x)
  (= (remainder x 2) 0))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))
