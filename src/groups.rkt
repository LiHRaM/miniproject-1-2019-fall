#lang racket

(define (group? obj)
    (eq? 'group (send 'type-of obj)))