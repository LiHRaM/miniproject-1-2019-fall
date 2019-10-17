#lang racket
(provide students)
(require "students/data.rkt")
(require "students/student.rkt")

(define students
    (map student students-raw))
