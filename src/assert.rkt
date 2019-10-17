#lang racket
(provide assert)

;;; Returns the value of the expression, unless it is false, in which case it errors with a message
(define (assert expr msg)
    (or expr (error "Assertion failed: " msg)))