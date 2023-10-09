#lang racket
(require "Flow_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;SELECTORES
;descripción: Función que selecciona un id de un chatbot
;recursión: no
;dom: chatbot
;rec: number
(define (get-chatbot-id some-chatbot) (car some-chatbot))

;descripción: Función que selecciona un nombre de un chatbot
;recursión: no
;dom: chatbot
;rec: string
(define (get-chatbot-name some-chatbot) (cadr some-chatbot))

;descripción: Función que selecciona un welcomeMessage de un chatbot
;recursión: no
;dom: chatbot
;rec: string
(define (get-chatbot-welcomeMessage some-chatbot) (caddr some-chatbot))

;descripción: Función que selecciona un Initialflow de un chatbot
;recursión: no
;dom: chatbot
;rec: number
(define (get-chatbot-Initialflow some-chatbot) (cadddr some-chatbot))

;descripción: Función que selecciona los flows de un chatbot
;recursión: no
;dom: chatbot
;rec: list
(define (get-chatbot-flows some-chatbot) (car (cddddr some-chatbot)))

;descripción: Función que selecciona un flow de un chatbot base a una id
;recursión: no
;dom: chatbot x id-flow(number)
;rec: list
(define (get-chatbot-flow-by-id some-chatbot id-flow) 
  (if (equal? null some-chatbot)
    null
    (if (null? (filter (lambda (flow) (equal? (get-flow-id flow) id-flow))
    (get-chatbot-flows some-chatbot)))
      null
      (car (filter (lambda (flow) (equal? (get-flow-id flow) id-flow))
      (get-chatbot-flows some-chatbot))))))

;MODIFICADOR
;descripción: Función que define un nuevo chatbot con una nueva lista de flows
;recursión: no
;dom: chatbot x flow-list(list)
;rec: chatbot
(define (set-chatbot-new-flow some-chatbot flow-list) (list 
    (get-chatbot-id some-chatbot) 
    (get-chatbot-name some-chatbot) 
    (get-chatbot-welcomeMessage some-chatbot) 
    (get-chatbot-Initialflow some-chatbot)
    flow-list))