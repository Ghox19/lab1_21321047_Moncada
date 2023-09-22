#lang racket
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Common_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un chatbot
;recursión: si, para verificar si se repite algun id de un flow
;dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows* 
;rec: chatbot
(define (chatbot id name welcomeMessage startFlowId . flows)
  (if (null? flows)
    (list id name welcomeMessage startFlowId flows)
    (list id name welcomeMessage startFlowId (eliminar-duplicados flows get-flow-id))))
  
;SELECTORES
(define (get-chatbot-id some-chatbot) (car some-chatbot));Extrae el id de un chatbot

(define (get-chatbot-name some-chatbot) (cadr some-chatbot));Extrae el nombre de un chatbot

(define (get-chatbot-welcomeMessage some-chatbot) (caddr some-chatbot));Extrae el mensaje de un chatbot

(define (get-chatbot-Initialflow some-chatbot) (cadddr some-chatbot))

(define (get-chatbot-flows some-chatbot) (car (cddddr some-chatbot)));Extrae los flows de un chatbot

(define (get-chatbot-active-flow some-chatbot id-flow) 
  (if (equal? -1 some-chatbot)
    -1
    (if (null? (filter (lambda (flow) (equal? (get-flow-id flow) id-flow))
    (get-chatbot-flows some-chatbot)))
      -1
      (car (filter (lambda (flow) (equal? (get-flow-id flow) id-flow))
      (get-chatbot-flows some-chatbot))))))

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
  (define (output some-chatbot flow) (list 
    (get-chatbot-id some-chatbot) 
    (get-chatbot-name some-chatbot) 
    (get-chatbot-welcomeMessage some-chatbot) 
    (get-chatbot-Initialflow some-chatbot)
    (rec-list-add (get-chatbot-flows some-chatbot) flow)))
  (if (null? (get-chatbot-flows some-chatbot))
      (output some-chatbot flow)
      (if (member (get-flow-id flow) (map get-flow-id (get-chatbot-flows some-chatbot)))
          some-chatbot
          (output some-chatbot flow))))