#lang racket
(provide assert)

(define (assert expr msg)
    (or expr (error "Assertion failed: " msg)))