#lang racket

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea opcion para flujo de un chatbot
;recursión: no
;dom: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword*
;rec: option
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (list code message ChatbotCodeLink FlowCodeLink Keyword))

;SELECTORES

(define (get-option-code some-option)(car some-option));Extrae el codigo de una opcion

(define (get-option-message some-option)(cadr some-option))

(define (get-option-ChatbotCodeLink some-option)(caddr some-option))

(define (get-option-InitialFlowCodeLink some-option)(cadddr some-option))

(define (get-option-keyword some-option)(car (cddddr some-option)))