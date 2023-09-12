#lang racket

;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: no
;dom: name (String)  X Option*
;rec: flow
(define (flow name . options)
  (list name options))

;MODIFICADORES
;descripción: Función que añade opciones a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (cons option some-flow))