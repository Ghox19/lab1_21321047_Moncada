#lang racket
(require "Option_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: si, para verificar si se repite algun code de un option
;dom: id (int) X name (String)  X Option*
;rec: flow
(define (flow id name . option)
  (define (eliminar-duplicados-option lst)
  (cond ((null? lst) '()) 
        ((member (get-option-code (car lst)) (map get-option-code (cdr lst)))
         (eliminar-duplicados-option (cdr lst))) 
        (else 
         (cons (car lst) (eliminar-duplicados-option (cdr lst)))))) 
  (if (null? option)
    (list id name option)
    (list id name (eliminar-duplicados-option option))
  ))

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