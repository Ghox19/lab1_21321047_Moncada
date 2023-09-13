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
    (display "No se puede realizar la accion debido a una duplicacion en los valores\n")
  ))


;MODIFICADORES
;descripción: Función que añade opciones a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (cons option some-flow))