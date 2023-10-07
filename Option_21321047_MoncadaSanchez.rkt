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
;dom: option
;rec: number
(define (get-option-code some-option)(car some-option))

;descripción: Función que selecciona un mensaje de una opcion
;recursión: no
;dom: option
;rec: string
(define (get-option-message some-option)(cadr some-option))

;descripción: Función que selecciona un ChatbotCodeLink de una opcion
;recursión: no
;dom: option
;rec: number
(define (get-option-ChatbotCodeLink some-option)(caddr some-option))

;descripción: Función que selecciona un InitialFlowCodeLink de una opcion
;recursión: no
;dom: option
;rec: number
(define (get-option-InitialFlowCodeLink some-option)(cadddr some-option))

;descripción: Función que selecciona las keywords de una opcion
;recursión: no
;dom: option
;rec: list
(define (get-option-keyword some-option)(car (cddddr some-option)))

;descripción: Función que selecciona una opcion base a un mensaje
;recursión: Recursion Natural
;dom: option-list(list) x message(string) x function-get(operation) x condition(Boolean Function)
;rec: option
(define (get-option-from-message-rec option-list message function-get condition)
  (if (null? option-list)
   null
    (if (condition message (function-get (car option-list)))
      (car option-list)
      (get-option-from-message-rec (cdr option-list) message function-get condition))))

;descripción: Función que selecciona una opcion base a un mensaje
;recursión: No
;dom: option-list(list) x message(string) x function-get(operation) x condition(Boolean Function)
;rec: list
(define (get-option-from-message option-list message function-get condition) 
  (if (null? (filter (lambda (option) (condition (function-get option) message))option-list))
    null
    (car (filter (lambda (option) (condition (function-get option) message))option-list))))