#lang racket

(provide (all-defined-out))

;CONSTRUCTORES
;descripción: Función que crea un mensaje de chatHistory
;recursión: no
;dom: user-name(string) x chatbot-id(number) x fow-id(number) x user-message(string)
;rec: message
(define (make-message some-user some-chatbot some-flow some-message) 
    (list (number->string (current-seconds)) some-user some-chatbot some-flow some-message))

;Selectores
;descripción: Función que selecciona una fecha de creacion de un chatHistory
;recursión: no
;dom: message
;rec: string
(define (get-message-date some-message) (car some-message))

;descripción: Función que selecciona un nombre de usuario de un chatHistory
;recursión: no
;dom: message
;rec: string
(define (get-message-user some-message) (cadr some-message))

;descripción: Función que selecciona un chatbot id de un chatHistory
;recursión: no
;dom: message
;rec: number
(define (get-message-chatbot some-message) (caddr some-message))

;descripción: Función que selecciona un flow id de un chatHistory
;recursión: no
;dom: message
;rec: number
(define (get-message-flow some-message) (cadddr some-message))

;descripción: Función que selecciona un mensaje de usuario de un chatHistory
;recursión: no
;dom: message
;rec: string
(define (get-message-user-message some-message) (car (cddddr some-message)))
