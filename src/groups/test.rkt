#lang racket
(require "../assert.rkt")
(require "../oop.rkt")
(require "../students.rkt")
(require "group.rkt")

(define test-group
    (group (list 1 (take students 5))))

(send 'print test-group)