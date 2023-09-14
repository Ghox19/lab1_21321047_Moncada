#lang racket
(require "Option_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: no
;dom: name (String)  X Option*
;rec: flow
(define (flow id name . options)
  (define (elementos-repetidos lst)
    (cond
      ((null? lst) #t)
      ((member (car lst) (cdr lst)) #f) 
      (else (elementos-repetidos (cdr lst)))))
  (if (elementos-repetidos (map get-option-code options))
    (list id name options)
    (display "")
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