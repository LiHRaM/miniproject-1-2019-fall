#lang racket
(provide student)


(define (student info)
    (let ([get-id        (first    info)]
          [get-name      (second   info)]
          [get-sex       (third    info)]
          [get-ethnicity (fourth   info)]
          [get-age       (fifth    info)]
          [type-of       (quote student)])
    (λ (message)
        (cond
            [(eq? message 'get-id) get-id]
            [(eq? message 'get-name) get-name]
            [(eq? message 'get-sex) get-sex]
            [(eq? message 'get-ethnicity) get-ethnicity]
            [(eq? message 'get-age) get-age]
            [(eq? message 'print) (λ ((prefix ""))
                (list
                    (format "~aId:        ~a ~n"   prefix  get-id)
                    (format "~aName:      ~a ~n"   prefix  get-name)
                    (format "~aSex:       ~a ~n"   prefix  get-sex)
                    (format "~aEthnicity: ~a ~n"   prefix  get-ethnicity)
                    (format "~aAge:       ~a ~n~n" prefix  get-age)
                )
            )]
            [(eq? message 'type-of) 'student]
            [else (error "Student does not support " message)]))))
