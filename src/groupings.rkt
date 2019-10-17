#lang racket
(provide group-random group-by-counting group-balanced-by-counting group-random-by-predicate grouping all-female? n-a-yrs-old? none-share-age?)
(require "groupings/grouping.rkt")
(require "types.rkt")
(require "assert.rkt")
(require "oop.rkt")

;;; Performs two assert functions (their behavior can be observed in the second value passed to assert)
;;; Passes structures on to the grab-students method with a predicate which always returns true
;;; As the predicate always returns true, we only need to pass the length of gsl as the amount of retries
(define (group-random sl gsl)
    (assert (andmap exact-nonnegative-integer? gsl) "gls: may only contain nonnegative integers!")
    (assert (= (apply + gsl) (length sl)) "sl: must have length of sum of gsl")
    (grab-students '() (shuffle sl) gsl (λ (group) #t) (length gsl)))

;;; Group by counting
;;; Uses a tail recursive helper function
;;; to iterate through the students, incrementing from 1 to k (inclusive)
(define (group-by-counting lst k)
  (define (helper result group-id students)
    (if (null? students)
        result
        (helper
          (cons (cons group-id (car students)) result)
          (+ 1 (modulo group-id k))
          (cdr students))))
  (helper '() 1 lst))

;;; Group students in a balanced way by counting
;;; Sorts by a concatenation of Gender and Ethnicity, e.g. "Male Danish"
;;; Once the sorting is done, pass it to the group-by-counting function
(define (group-balanced-by-counting lst k)
  (let* ([extract-key (λ (el) (string-append (send 'get-sex el) " " (send 'get-ethnicity el)))]
         [sort (sort lst string<? #:key extract-key)])
    (group-by-counting sort k)))

;;; Same as group-random except for two points:
;;; It allows the caller to define 
;;; 1. the predicate by which groups are accepted, and
;;; 2. the amount of times the helper function will retry if a group is rejected
(define (group-random-by-predicate sl gsl pred retries)
  (assert (andmap exact-nonnegative-integer? gsl) "gls: may only contain nonnegative integers!")
  (assert (= (apply + gsl) (length sl)) "sl: must have length of sum of gsl")
  (grab-students '() (shuffle sl) gsl pred retries))

;;; Grab students takes in a list of students and a list of group sizes
;;; and randomly 'grabs' students from the student list, matching them against a predicate
;;; if the predicate fails, then the function tries again, decrementing the retries
(define (grab-students result students source pred? retries)
  (if (or (null? source) (zero? retries))
        result
        (let*
           ([group-number (length source)]
            [crnt   (car source)]
            [group  (take students crnt)]
            [src    (if (pred? group) (cdr source) source)]
            [stdnts (if (pred? group) (list-tail students crnt) (shuffle students))]
            [rslt   (if (pred? group) (append (map (λ (el) (cons group-number el)) group) result) result)])
          (grab-students rslt stdnts src pred? (- retries 1)))))

;;; Checks whether all students in a group are female
(define (all-female? group)
    (let* ([female? (λ (el) (eqv? "female" (send 'get-sex el)))]
           [difference (- (length group) (length (filter female? group)))])
    (zero? difference)))

;;; Given an age and a count, returns a predicate
;;; Which applies a-yrs-old? to the entire group
(define (n-a-yrs-old? count age)
  (let 
    ([a-yrs-old? (λ (el) (>= (send 'get-age el) age))])
    (assert (exact-nonnegative-integer? age) "age: must be a positive integer")
    (assert (exact-nonnegative-integer? count) "count: must be a positive integer")
    (λ (group)
      (>= (length (map a-yrs-old? group)) count))))

;;; No students in the group are of the same age.
;;; Map students to list of ages
;;; Check duplicates
(define (none-share-age? group)
  (let*
    ([age  (λ (student) (send 'get-age student))]
     [ages (map age group)])
    (check-duplicates ages)))