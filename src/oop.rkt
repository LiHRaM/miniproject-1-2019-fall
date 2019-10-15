#lang racket
(provide (all-defined-out))

;;; Simple message passing as demonstrated by Kurt
;;; In lecture 3 @ AAU
;;; Applies a method to the parameters if they exist
(define (send message obj . par)
  (let ((res (obj message)))
    (if (procedure? res)
        (apply res par)
        res)))
