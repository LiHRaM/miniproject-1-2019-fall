#lang racket
(provide group? group)
(require "../oop.rkt")

(define (group? obj)
    (eq? 'group (send 'type-of obj)))

;;; lst is an associated list
;;; '(1 (a e c))
(define (group lst)
    (let ([get-id (car lst)]
          [get-students (cadr lst)])
    (λ (message)
        (cond
            [(eq? message 'get-id) get-id]
            [(eq? message 'get-students) get-students]
            [(eq? message 'get-length) (length get-students)]
            [(eq? message 'print) (λ ((prefix ""))
                (cons
                    (format "~aGroup: ~a~n" prefix get-id)
                    (map 
                        (λ (student)
                            (send 'print student (format "~a  " prefix))) 
                        get-students))
                )]
            [(eq? message 'type-of) 'group]))))