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

;SELECTORES
(define (get-system-date some-system) (car some-system));Extrae la fecha de creacion de un sistema

(define (get-system-name some-system) (caadr some-system));Extrae el nombre del sistema

(define (get-system-user some-system) (cadadr some-system))

(define (get-system-chatHistory some-system) (cadr (cdadr some-system)))

(define (get-system-initialchatbotcodelink some-system) (caddr (cdadr some-system)));Extrae el primer chatbot del sistema

(define (get-system-chatbots some-system) (cadddr (cdadr some-system)));Extrae la lista de chatbots del sistema

(define (get-system-initial-chatbot some-system) 
  (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) (get-system-initialchatbotcodelink some-system)))
  (get-system-chatbots some-system))))

;MODIFICADORES
;descripción: Función añade chatbots al sistema
;recursión: no
;dom: system X chatbot
;rec: system
(define (system-add-chatbot some-system chatbot)
  (define (output-chatbot some-system chatbot) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      (get-system-user some-system) 
      (get-system-chatHistory some-system) 
      (get-system-initialchatbotcodelink some-system)
      (reverse (cons chatbot (reverse (get-system-chatbots some-system)))))))
    (if (member (get-chatbot-id chatbot) (map get-chatbot-id (get-system-chatbots some-system)))
        some-system
        (output-chatbot some-system chatbot)))

;descripción: Función añade un usuario al sistema
;recursión: no
;dom: system X user
;rec: system
(define (system-add-user some-system user)
  (define (output-user some-system user) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      (reverse (cons user (reverse (get-system-user some-system)))) 
      (get-system-chatHistory some-system) 
      (get-system-initialchatbotcodelink some-system)
      (get-system-chatbots some-system))))
  (if (null? (get-system-user some-system))
    (output-user some-system (make-user user))
    (if (member user (map get-user-name (get-system-user some-system)))
      some-system
      (output-user some-system (make-user user)))))