#lang racket
(require "Option_21321047_MoncadaSanchez.rkt")
(require "Common_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: si, para verificar si se repite algun code de un option
;dom: id (int) X name (String)  X Option*
;rec: flow
(define (flow id name . option)
  (list id name (eliminar-duplicados option get-option-code)))

;Selectores
(define (get-flow-id some-flow) (car some-flow));Extrae el ID de un flow

(define (get-flow-name some-flow)(cadr some-flow));Extrae nombre del flow

(define (get-flow-option some-flow)(caddr some-flow));Extrae lst de opciones de un flow

;MODIFICADORES
;descripción: Función que añade opciones a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (define (output some-flow option) 
    (list (get-flow-id some-flow) 
    (get-flow-name some-flow) 
    (insertar-final-lista option (get-flow-option some-flow))))
  (if (null? (get-flow-option some-flow))
      (output some-flow option)
      (if (member (get-option-code option) (map get-option-code (get-flow-option some-flow)))
          (display "")
          (output some-flow option))))


;Otras funciones

(define (get-option-from-message-rec option-list message function-get condition)
  (if (null? option-list)
   -1
    (if (condition message (function-get (car option-list)))
      (car option-list)
      (get-option-from-message-rec (cdr option-list) message function-get condition))))

(define (get-option-from-message option-list message function-get condition) 
  (if (null? (filter (lambda (option) (condition (function-get option) message))option-list))
    -1
    (car (filter (lambda (option) (condition (function-get option) message))option-list))))

(define (get-flow-option-from-message-rec some-flow message) 
  (if (equal? -1 some-flow)
    -1
    (if (string->number message)
      (get-option-from-message-rec (get-flow-option some-flow) (string->number message) get-option-code equal?)
      (get-option-from-message-rec (get-flow-option some-flow) message get-option-keyword member))))

(define (get-flow-option-from-message some-flow message)
  (if (equal? -1 some-flow)
    -1
    (if (string->number message)
      (get-option-from-message (get-flow-option some-flow) (string->number message) get-option-code equal?)
      (get-option-from-message (get-flow-option some-flow) message get-option-keyword member))))

(define (get-flow-options-format some-flow) 
  (string-join (map get-option-message (get-flow-option some-flow)) "\n"))