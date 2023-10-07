#lang racket

(provide (all-defined-out))

(define (eliminar-duplicados lista function-get)
    (if (null? lista) '()
        (cons (car lista) (eliminar-duplicados
            (filter (lambda (x) (not (equal? (function-get x) (function-get (car lista)))))
            (cdr lista)) function-get))))

(define (rec-list-add lst arg)
    (if (null? lst)
    (list arg)
    (cons (car lst) (rec-list-add (cdr lst) arg))))

(define (insertar-final-lista elemento lista)
  (reverse (cons elemento (reverse lista))))

(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648))