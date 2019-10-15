#lang racket
(provide students)
(require "students/data.rkt")
(require "students/student.rkt")

(define students
    (process-students students-raw))
