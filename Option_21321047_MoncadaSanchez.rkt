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
;descripción: Función que selecciona un code de una opcion
;recursión: no
;dom: option(list)
;rec: number
(define (get-option-code some-option)(car some-option))

;descripción: Función que selecciona un mensaje de una opcion
;recursión: no
;dom: option(list)
;rec: string
(define (get-option-message some-option)(cadr some-option))

;descripción: Función que selecciona un ChatbotCodeLink de una opcion
;recursión: no
;dom: option(list)
;rec: number
(define (get-option-ChatbotCodeLink some-option)(caddr some-option))

;descripción: Función que selecciona un InitialFlowCodeLink de una opcion
;recursión: no
;dom: option(list)
;rec: number
(define (get-option-InitialFlowCodeLink some-option)(cadddr some-option))

;descripción: Función que selecciona las keywords de una opcion
;recursión: no
;dom: option(list)
;rec: list
(define (get-option-keyword some-option)(car (cddddr some-option)))