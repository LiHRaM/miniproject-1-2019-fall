;;;  Author: Hilmar Gústafsson
;;; Studynr: 20165000
;;;   Email: hgusta16@student.aau.dk

;;; Status of program:
;;; Everything except for the final grouping function has been implemented.
;;; To be specific, the assignment which extends the random grouping function with a predicate.

;;; Racket 7.0 was used in the making of this program.

#lang racket
(require "oop.rkt")
(require "students.rkt")
(require "groups.rkt")
(require "groupings.rkt")

(define stdnts (take students 20))

(define groupings
    (list 
        (grouping (group-random stdnts '(10 10)))
        (grouping (group-by-counting stdnts 5))
        (grouping (group-balanced-by-counting stdnts 5))))

(for-each (λ (el)
    (for-each (λ (str)
        (display str)) 
        (send 'print el)))
    groupings)