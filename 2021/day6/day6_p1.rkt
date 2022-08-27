#lang racket

;; This is the first time I'm using racket/scheme to solve a problem so this code might be terrible. Also the compile time on this
;; is like 25 minutes, So I'll just comment the output here:

;; Call: (length (day6 fishlist 81))
;; Result: 353079

;; I didn't know how to optimise the second part of the problem in racket, so I didn't write that part of day6

(define fishlist
   (file->list "input.txt")
  )

(define decrement
  (lambda (L)
    (cond ( [null? L]          '() )
          ( [equal? (car L) 0] (cons 6 (decrement (cdr L))) )
          ( #t                 (cons (- (car L) 1) (decrement (cdr L))) )
          )
    )
  )

(define addFish
  (lambda (L)
    (cond ( [null? L]                 '() )
          ( [equal? (car L) 0]        (cons (car L) (append (addFish (cdr L)) (list 9))) )
          ( #t                        (cons (car L) (addFish (cdr L))) )
          )
    )
  )

(define nextDay
  (lambda (L)
    (decrement (addFish L))
    )
  )

(define printLast
  (lambda (L)
    (cond ( [null? (cdr L)] (car L) )
          ( #t              (printLast (cdr L)))
          )
    )
  )

(define iterateDays
  (lambda (L D)
    (cond ( [equal? D 0] '() )
          ( #t  (cons L (iterateDays (nextDay L) (- D 1))) )
    )
  )
  )

(define day6
  (lambda (D)
    (printLast (iterateDays fishlist D))
    )
  )