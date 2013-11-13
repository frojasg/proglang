
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))


(define (list-nth-mod xs n)
  (if (< n 0)
      (error "list-nth-mod: negative number")
      (if (empty? xs)
          (error "list-nth-mod: empty list")
          (car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (if (>= 0 n)
      null
      (let ([x (s)])
        (cons (car x) (stream-for-n-steps (cdr x) (- n 1))))))


(define funny-number-stream 
  (letrec ([f (lambda(x)  
    (let ([y (if (= 0 (remainder x 5))
                 (* x -1)
                 x)])
      (cons y (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

(define dan-then-dog 
  (letrec ([dan (lambda() (cons "dan.jpg" (lambda () (dog))))]
           [dog (lambda() (cons "dog.jpg" (lambda () (dan))))])
    (lambda () (dan))))

(define (stream-add-zero s) 
  (letrec ([f (lambda (ss) (cons (cons 0 (car (ss))) (lambda () (f (cdr ss)))))])
    (lambda () (f s))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda(x) (cons 
                          (cons (list-nth-mod xs x) (list-nth-mod ys x))
                          (lambda () (f (+ x 1 )))))])
    (lambda () (f 0))))


(define (vector-assoc v vec)
  (letrec ([search (lambda(i) 
                  (if (>= i (vector-length vec))
                      #f
                      (let ([x (vector-ref vec i)])
                        (if (and (pair? x) (equal? v (car x)))
                            x
                            (search (+ 1 i))))))])
    (search 0)))
                          

(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [index 0]
           [f (lambda(v)
                (let ([ans (vector-assoc v memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (assoc v xs)])
                        (begin
                          (vector-set! memo index new-ans)
                          (set! index (remainder n (+ index 1)))
                          new-ans)))))])
    f))




