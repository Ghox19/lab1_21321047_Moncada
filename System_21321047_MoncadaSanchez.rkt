#lang racket
(require "Common_21321047_MoncadaSanchez.rkt")
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Option_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")
(require "Chat_History_21321047_MoncadaSanchez.rkt")
(require "Date_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un sistema con chatbots
;recursión: si, para verificar si se repite algun id de chatbot
;dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;rec: system
(define (system name initialchatbotcodelink . chatbot)
  (if (null? chatbot)
    (list (make-date) (list name null null initialchatbotcodelink chatbot))
    (list (make-date) (list name null null initialchatbotcodelink initialchatbotcodelink 
    (get-chatbot-Initialflow (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) 
    initialchatbotcodelink)) chatbot))) (eliminar-duplicados chatbot get-chatbot-id)))))

;SELECTORES
(define (get-system-date some-system) (car some-system));Extrae la fecha de creacion de un sistema

(define (get-system-name some-system) (caadr some-system));Extrae el nombre del sistema

(define (get-system-user some-system) (cadadr some-system))

(define (get-system-chatHistory some-system) (cadr (cdadr some-system)))

(define (get-system-initialchatbotcodelink some-system) (caddr (cdadr some-system)));Extrae el primer chatbot del sistema

(define (get-system-Activechatbotcodelink some-system) (cadddr (cdadr some-system)))

(define (get-system-Activeflowcodelink some-system) (car (cddddr (cdadr some-system))))

(define (get-system-chatbots some-system) (cadr (cddddr (cdadr some-system))));Extrae la lista de chatbots del sistema

(define (get-system-active-chatbot some-system) 
  (if(null? (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) (get-system-Activechatbotcodelink some-system)))
  (get-system-chatbots some-system)))
    -1
    (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) (get-system-Activechatbotcodelink some-system)))
    (get-system-chatbots some-system)))))

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
      (get-system-Activechatbotcodelink some-system)
      (get-system-Activeflowcodelink some-system)
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
      (get-system-Activechatbotcodelink some-system)
      (get-system-Activeflowcodelink some-system)
      (get-system-chatbots some-system))))
  (if (null? (get-system-user some-system))
    (output-user some-system (make-user user))
    (if (member user (map get-user-name (get-system-user some-system)))
      some-system
      (output-user some-system (make-user user)))))

;OTRAS FUNCIONES

;descripción: Función que permite iniciar una sesión en el sistema.
;recursión: no
;dom: system X user
;rec: system
(define (system-login some-system user)
  (define (output-login some-system user) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      (get-login-user-list (get-system-user some-system) user) 
      (get-system-chatHistory some-system) 
      (get-system-initialchatbotcodelink some-system)
      (get-system-Activechatbotcodelink some-system)
      (get-system-Activeflowcodelink some-system)
      (get-system-chatbots some-system))))
  (if (is-login-user (get-system-user some-system))
    some-system
    (output-login some-system user)))