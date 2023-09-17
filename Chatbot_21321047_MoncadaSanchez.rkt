#lang racket
(require "Flow_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un chatbot
;recursión: si, para verificar si se repite algun id de un flow
;dom: chatbotID (int) X name (String) X welcomeMessage (String)  X  flows*
;rec: chatbot
(define (chatbot id name welcomeMessage . flows)
  (define (eliminar-duplicados-flow lista)
    (cond ((null? lista) '())
    (else (cons (car lista) (eliminar-duplicados-flow
      (filter (lambda (x) (not (equal? (get-flow-id x) (get-flow-id (car lista))))) (cdr lista)))))))
  (if (null? flows)
    (list id name welcomeMessage flows)
    (list id name welcomeMessage (eliminar-duplicados-flow flows))
  ))

;SELECTORES
(define (get-chatbot-id some-chatbot) (car some-chatbot));Extrae el id de un chatbot

(define (get-chatbot-name some-chatbot) (cadr some-chatbot));Extrae el nombre de un chatbot

(define (get-chatbot-welcomeMessage some-chatbot) (caddr some-chatbot));Extrae el mensaje de un chatbot

(define (get-chatbot-flows some-chatbot) (cadddr some-chatbot));Extrae los flows de un chatbot

;MODIFICADOR
;descripción: Función añadir flujos a un chatbot
;recursión: si, debido a que se recorre hasta encontrar el ultimo
;dom: chatbot X flow
;rec: chatbot
(define (chatbot-add-flow some-chatbot flow)
  (define (rec-list-add lst arg)
    (if (null? lst)
    (list arg)
    (cons (car lst) (rec-list-add (cdr lst) arg))))
  (define (output some-chatbot flow) (list (get-chatbot-id some-chatbot) (get-chatbot-name some-chatbot) (get-chatbot-welcomeMessage some-chatbot) 
  (rec-list-add (get-chatbot-flows some-chatbot) flow)))
  (if (null? (get-chatbot-flows some-chatbot))
      (output some-chatbot flow)
      (if (member (get-flow-id flow) (map get-flow-id (get-chatbot-flows some-chatbot)))
          some-chatbot
          (output some-chatbot flow))))