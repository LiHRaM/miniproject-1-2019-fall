;;; Here we list all the type predicates for easy access

#lang racket
(provide student? group? grouping?)
(require "oop.rkt")

(define (get-type obj)
    (send 'type-of obj))

(define (student? obj)
    (eq? 'student (get-type obj)))

(define (group? obj)
    (eq? 'group (get-type obj)))

(define (grouping? obj)
    (eq? 'grouping (get-type obj)))