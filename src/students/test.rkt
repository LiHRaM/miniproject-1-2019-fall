#lang racket
(require "data.rkt")
(require "student.rkt")
(require "../oop.rkt")

(define my-student 
    (student (first students-raw)))

(for-each (λ (el) (println el))
    (send 'print my-student))