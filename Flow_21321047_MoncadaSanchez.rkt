#lang racket
(require "Option_21321047_MoncadaSanchez.rkt")
(require "Common_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función que crea un flujo de un chatbot
;recursión: Recursion Natural en la funcion "eliminar-duplicados"
;dom: id (int) X name (String)  X Option*
;rec: flow
(define (flow id name . option)
  (list id name (eliminar-duplicados option get-option-code)))

;Selectores
;descripción: Función que selecciona un id de un flow
;recursión: no
;dom: flow
;rec: number
(define (get-flow-id some-flow) (car some-flow));Extrae el ID de un flow

;descripción: Función que selecciona un nombre de un flow
;recursión: no
;dom: flow
;rec: string
(define (get-flow-name some-flow)(cadr some-flow));Extrae nombre del flow

;descripción: Función que selecciona las opciones de un flow
;recursión: no
;dom: flow
;rec: list
(define (get-flow-option some-flow)(caddr some-flow));Extrae lst de opciones de un flow

;descripción: Función que obtiene una opcion base a un mensaje
;recursión: Recursion natural en la funcion "get-option-from-message-rec"
;dom: flow X message(string)
;rec: option
(define (get-flow-option-from-message-rec some-flow message) 
  (if (equal? null some-flow)
    null
    (if (string->number message)
      (get-option-from-message-rec (get-flow-option some-flow) (string->number message) get-option-code equal?)
      (get-option-from-message-rec (get-flow-option some-flow) message get-option-keyword member))))

;descripción: Función que obtiene una opcion base a un mensaje
;recursión: No
;dom: flow X message(string)
;rec: option
(define (get-flow-option-from-message some-flow message)
  (if (equal? null some-flow)
    null
    (if (string->number message)
      (get-option-from-message (get-flow-option some-flow) (string->number message) get-option-code equal?)
      (get-option-from-message (get-flow-option some-flow) message get-option-keyword member))))

;descripción: Función que obtiene las opciones que contiene en formato de texto
;recursión: No
;dom: flow
;rec: string
(define (get-flow-options-format some-flow) 
  (string-join (map get-option-message (get-flow-option some-flow)) "\n"))

;MODIFICADORES
;descripción: Función que define un nuevo flow con una nueva lista de opciones
;recursión: no
;dom: flow X option
;rec: flow
(define (set-flow-new-option some-flow option) 
    (list (get-flow-id some-flow) 
          (get-flow-name some-flow) 
          option))

;descripción: Función que añade opciones a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (if (null? (get-flow-option some-flow))
      (set-flow-new-option some-flow option)
      (if (member (get-option-code option) (map get-option-code (get-flow-option some-flow)))
          (display "")
          (set-flow-new-option some-flow (insertar-final-lista option (get-flow-option some-flow))))))