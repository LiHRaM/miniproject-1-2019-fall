#lang racket
(require "grouping.rkt")
(require "../oop.rkt")

(define my-grouping
    (grouping-ctor '((1 . a) (1 . e) (2 . b) (1 . c) (2 . d))))

(send 'get-group my-grouping 1)
(send 'get-groups-count my-grouping)
(send 'get-groups-max-size my-grouping)
(send 'get-groups-min-size my-grouping)
(send 'type-of my-grouping)