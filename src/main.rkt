;;;  Author: Hilmar Gústafsson
;;; Studynr: 20165000
;;;   Email: hgusta16@student.aau.dk

;;; Status of program:
;;; Everything except for the final grouping function has been implemented.
;;; To be specific, the assignment which extends the random grouping function with a predicate.

;;; Racket 7.0 was used in the making of this program.

;;; This is the designated entry point of the program
;;; It calls the main grouping functions and prints their results

#lang racket
(require "oop.rkt")
(require "students.rkt")
(require "groups.rkt")
(require "groupings.rkt")

(define stdnts (take students 200))

(define groupings
    (list 
        (grouping (group-random stdnts '(10 20 30 20 10 20 30 20 10 20 10)))
        (grouping (group-by-counting stdnts 5))
        (grouping (group-balanced-by-counting stdnts 5))
        (grouping (group-random-by-predicate stdnts '(5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 10 20 30 20 10 20 15) all-female? 1000))
        (grouping (group-random-by-predicate stdnts '(5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 10 20 30 20 10 20 15) (n-a-yrs-old? 1 1) 1000))
        (grouping (group-random-by-predicate stdnts '(5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 10 20 30 20 10 20 15) none-share-age? 1000))
    ))

(for-each (λ (el)
    (for-each (λ (str)
        (display str)) 
        (send 'print el)))
    groupings)