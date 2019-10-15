#lang racket
(provide grouping? grouping)
(require "../oop.rkt")
(require "../groups/group.rkt")

(define (grouping? obj)
    (eq? (send 'type-of obj) 'grouping))

(define (grouping lst)
    (let* ([ids (remove-duplicates (map (λ (el) (car el)) lst))]
           [get-group (λ (group-id)
                         (group
                            (cons 
                                group-id 
                                (list
                                    (filter-map (λ (el) 
                                        (and (eq? group-id (car el)) (cdr el))) 
                                        lst)))))]
           [sizes (map (λ (el) (send 'get-length (get-group (car el)))) lst)]
           [get-groups-count (length ids)]
           [get-groups-max-size (apply max sizes)]
           [get-groups-min-size (apply min sizes)])
    (λ (message)
        (cond
            [(eq? message 'get-group) get-group]
            [(eq? message 'get-groups-count) get-groups-count]
            [(eq? message 'get-groups-max-size) get-groups-max-size]
            [(eq? message 'get-groups-min-size) get-groups-min-size]
            [(eq? message 'print) (λ ()
                (flatten 
                    (list
                        (format "GROUPING~n")
                        (format "Group count: ~a~n" get-groups-count)
                        (format "Group max size: ~a~n" get-groups-max-size)
                        (format "Group min size: ~a~n" get-groups-min-size)
                        (map (λ (id)
                            (send 'print (get-group id) "  "))
                            ids)))
            )]
            [(eq? message 'type-of) 'grouping]))))


