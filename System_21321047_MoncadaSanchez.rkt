#lang racket
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un sistema con chatbots
;recursión: si, para verificar si se repite algun id de chatbot
;dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;rec: system
(define (system name initialchatbotcodelink . chatbot)
  (define (eliminar-duplicados-chatbot lista)
    (cond ((null? lista) '()) ;Si la lista es vacia devuelve null
          (else
          (cons (car lista) (eliminar-duplicados-chatbot
            (filter (lambda (x) (not (equal? (get-chatbot-id x) (get-chatbot-id (car lista))))) 
            (cdr lista)))))))
  (if (null? chatbot)
    (list (current-seconds) (list name null null initialchatbotcodelink chatbot))
    (list (current-seconds) (list name null null initialchatbotcodelink 
    (eliminar-duplicados-chatbot chatbot)))))
