#lang racket

(provide (all-defined-out))

;Otras Funciones
;descripción: Función que elimina los duplicados de una lista
;recursión: Recursion Natural, debido a que recorre cada elemento de la lista y lo filtra del resto de esta
;dom: lista(list) x function-get(funcion para extraer elemento a comparar)
;rec: list
(define (eliminar-duplicados lista function-get)
    (if (null? lista) '()
        (cons (car lista) (eliminar-duplicados
            (filter (lambda (x) (not (equal? (function-get x) (function-get (car lista)))))
            (cdr lista)) function-get))))

;descripción: Función que añade un elemento a una lista
;recursión: Recursion Natural, debido a que solicita una recursion en el ingreso de una variable en ciertas funciones
;dom: lst(list) x arg(argumento a ingresar)
;rec: list
(define (rec-list-add lst arg)
    (if (null? lst)
    (list arg)
    (cons (car lst) (rec-list-add (cdr lst) arg))))

;descripción: Función que añade un elemento a una lista
;recursión: no
;dom: elemento(argumento a ingresar) x lista(list)
;rec: list
(define (insertar-final-lista elemento lista)
  (reverse (cons elemento (reverse lista))))

;descripción: Función que genera un numero pseudocodigo
;recursión: no
;dom: Xn(number)
;rec: number
(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648))