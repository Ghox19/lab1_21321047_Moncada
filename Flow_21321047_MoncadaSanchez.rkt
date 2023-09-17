#lang racket
(require "Option_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: si, para verificar si se repite algun code de un option
;dom: id (int) X name (String)  X Option*
;rec: flow
(define (flow id name . option)
  (define (eliminar-duplicados-option lista)
    (cond ((null? lista) '()) ;Si la lista es vacia devuelve null
          (else
          (cons (car lista) ;Extrae el primer elemento de la lista y aplica un filtro a la lista
                (eliminar-duplicados-option
                  (filter (lambda (x) (not (equal? (get-option-code x) (get-option-code (car lista))))) 
                  (cdr lista)))))));Asi elimina todos los elementos repetidos a travez del filtro y trabaja con la lista restante
  (list id name (eliminar-duplicados-option option)))

;Selectores
(define (get-flow-id some-flow) (car some-flow));Extrae el ID de un flow

(define (get-flow-name some-flow)(cadr some-flow));Extrae nombre del flow

(define (get-flow-options some-flow)(caddr some-flow));Extrae lista de opciones de un flow

;MODIFICADORES
;descripción: Función que añade opciones a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (define (output some-flow option) (list (get-flow-id some-flow) (get-flow-name some-flow) (reverse (cons option (reverse (get-flow-options some-flow))))))
  (if (null? (get-flow-options some-flow))
      (output some-flow option)
      (if (member (get-option-code option) (map get-option-code (get-flow-options some-flow)))
          (display "")
          (output some-flow option))))