#lang racket
(provide group-random group-by-counting group-balanced-by-counting group-random-by-predicate grouping)
(require "groupings/grouping.rkt")
(require "assert.rkt")
(require "oop.rkt")

(define (group-random sl gsl)
  (let ([rsl (shuffle sl)]
        [gls-is-natural-nums? (andmap exact-nonnegative-integer? gsl)])
    (assert gls-is-natural-nums? "Gls may only contain nonnegative integers!")
    (assert (= (apply + gsl) (length sl)) "Student list must have length of sum of gsl")
    (grab-students '() sl gsl)))

(define (grab-students result students source)
  (if (null? source)
        result
        (let*
          ([group-number (length source)]
           [crnt   (λ () (car source))]
           [src    (λ () (cdr source))]
           [stdnts (λ () (list-tail students (crnt)))]
           [rslt   (λ () (append (map (λ (el) (cons group-number el)) (take students (crnt))) result))])
          (grab-students (rslt) (stdnts) (src)))))

(define (group-by-counting lst k)
  (letrec ([helper (λ (result group-id students)
                      (if (null? students)
                          result
                          (helper 
                            (cons (cons group-id (car students)) result) 
                            (+ 1 (modulo group-id k)) 
                            (cdr students))))])
    (helper '() 1 lst)))


(define (group-balanced-by-counting lst k)
  (let* ([extract-sex (λ (el) (send 'get-sex el))]
         [sort-once (sort lst string<? #:key extract-sex)]
         [extract-ethnicity (λ (el) (send 'get-ethnicity el))]
         [sort-twice (sort sort-once string<? #:key extract-ethnicity)])
    (group-by-counting sort-twice k)))

(define (group-random-by-predicate lst sizes)
  (print "Not implemented yet!"))