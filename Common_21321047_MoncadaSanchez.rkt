#lang racket

(provide (all-defined-out))

(define (eliminar-duplicados lista function-get)
    (if (null? lista) '()
        (cons (car lista) (eliminar-duplicados
            (filter (lambda (x) (not (equal? (function-get x) (function-get (car lista)))))
            (cdr lista)) function-get))))
