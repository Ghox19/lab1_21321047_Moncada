#lang racket

;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: no
;dom: name (String)  X Option*
;rec: flow
(define (flow name . options)
  (list name options))