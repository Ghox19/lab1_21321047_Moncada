#lang racket
(require "Common_21321047_MoncadaSanchez.rkt")
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Option_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")
(require "Chat_History_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un sistema con chatbots
;recursión: si, para verificar si se repite algun id de chatbot
;dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;rec: system
(define (system name initialchatbotcodelink . chatbot)
  (if (null? chatbot)
    (list (current-seconds) (list name null null initialchatbotcodelink chatbot))
    (list (current-seconds) (list name null null initialchatbotcodelink initialchatbotcodelink 
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

(define (get-system-chatbot-from-id some-system id-chatbot) 
  (if(null? (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) id-chatbot))
  (get-system-chatbots some-system)))
    -1
    (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) id-chatbot))
    (get-system-chatbots some-system)))))

;MODIFICADORES
(define (set-system-chatbot some-system chatbot) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        (get-system-user some-system) 
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        chatbot)))

(define (set-system-user some-system user-list) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        user-list
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        (get-system-chatbots some-system))))

(define (set-system-login some-system user-list) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        user-list
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        (get-system-chatbots some-system))))

(define (set-system-logout some-system user-list initial-flow) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      user-list 
      (get-system-chatHistory some-system) 
      (get-system-initialchatbotcodelink some-system)
      (get-system-initialchatbotcodelink some-system)
      initial-flow
      (get-system-chatbots some-system))))

(define (set-system-talk some-system activechatbotcode activeflowcode chatHistory) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      (get-system-user some-system) 
      chatHistory
      (get-system-initialchatbotcodelink some-system)
      activechatbotcode
      activeflowcode
      (get-system-chatbots some-system))))

(define (set-system-notalk some-system chatHistory) 
    (list (get-system-date some-system) 
      (list (get-system-name some-system) 
      (get-system-user some-system) 
      chatHistory
      (get-system-initialchatbotcodelink some-system)
      (get-system-Activechatbotcodelink some-system)
      (get-system-Activeflowcodelink some-system)
      (get-system-chatbots some-system))))

;descripción: Función añade chatbots al sistema
;recursión: no
;dom: system X chatbot
;rec: system
(define (system-add-chatbot some-system chatbot)
  (if (member (get-chatbot-id chatbot) (map get-chatbot-id (get-system-chatbots some-system)))
    some-system
    (set-system-chatbot some-system (insertar-final-lista chatbot (get-system-chatbots some-system)))))

;descripción: Función añade un usuario al sistema
;recursión: no
;dom: system X user
;rec: system
(define (system-add-user some-system some-user)
  (if (null? (get-system-user some-system))
    (set-system-user some-system (insertar-final-lista (make-user some-user) (get-system-user some-system)))
    (if (member some-user (map get-user-name (get-system-user some-system)))
      some-system
      (set-system-user some-system (insertar-final-lista (make-user some-user) (get-system-user some-system))))))

;OTRAS FUNCIONES

;descripción: Función que permite iniciar una sesión en el sistema.
;recursión: no
;dom: system X user
;rec: system
(define (system-login some-system user)
  (if (is-login-user (get-system-user some-system))
    some-system
    (set-system-login some-system (get-login-user-list (get-system-user some-system) user))))

;descripción: Función que permite iniciar una sesión en el sistema.
;recursión: no
;dom: system X user
;rec: system
(define (system-logout some-system)
  (if (is-login-user (get-system-user some-system))
    (set-system-logout some-system (get-logout-user-list (get-system-user some-system)) (get-chatbot-Initialflow (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) 
    (get-system-initialchatbotcodelink some-system))) (get-system-chatbots some-system)))))
    some-system))

;descripción:  Función que permite interactuar con un chatbot.
;recursión: si, Recursion Natural en la busqueda de la opcion desde el flow
;dom: system X message (string)
;rec: system

(define (insertar-mensaje-chatHistory some-system message) 
        (insertar-final-lista (make-message (get-user-name (get-login-user 
        (get-system-user some-system))) (get-chatbot-id (get-system-active-chatbot some-system)) 
        (get-system-Activeflowcodelink some-system) message) (get-system-chatHistory some-system)))

(define (get-system-option-from-message-rec some-system message) 
      (get-flow-option-from-message-rec (get-chatbot-active-flow 
      (get-system-active-chatbot some-system)(get-system-Activeflowcodelink some-system)) message))

(define (get-system-option-from-message some-system message) 
      (get-flow-option-from-message (get-chatbot-active-flow 
      (get-system-active-chatbot some-system)(get-system-Activeflowcodelink some-system)) message))

(define (system-talk-rec some-system message)
  (if (not (is-login-user (get-system-user some-system)))
  (set-system-notalk some-system (insertar-mensaje-chatHistory some-system message))
    (if (equal? -1 (get-flow-option-from-message-rec (get-chatbot-active-flow 
    (get-system-active-chatbot some-system)(get-system-Activeflowcodelink some-system)) message))
      (set-system-notalk some-system (insertar-mensaje-chatHistory some-system message))
      (set-system-talk some-system 
        (get-option-ChatbotCodeLink (get-system-option-from-message-rec some-system message))
        (get-option-InitialFlowCodeLink (get-system-option-from-message-rec some-system message))
        (insertar-mensaje-chatHistory some-system message)))))

;descripción:  Función que permite interactuar con un chatbot.
;recursión: no
;dom: system X message (string)
;rec: system
(define (system-talk some-system message)
  (if (not (is-login-user (get-system-user some-system)))
  (set-system-notalk some-system (insertar-mensaje-chatHistory some-system message))
    (if (equal? -1 (get-flow-option-from-message (get-chatbot-active-flow 
      (get-system-active-chatbot some-system)(get-system-Activeflowcodelink some-system)) message))
      (set-system-notalk some-system (insertar-mensaje-chatHistory some-system message))
      (set-system-talk some-system 
        (get-option-ChatbotCodeLink (get-system-option-from-message some-system message))
        (get-option-InitialFlowCodeLink (get-system-option-from-message some-system message))
        (insertar-mensaje-chatHistory some-system message)))))

(define (get-message-display-format some-message some-system)
  (string-append 
    (get-message-date some-message) " - " (get-message-user some-message) ": "
    (get-message-user-message some-message) "\n"
    (get-message-date some-message) " - "
    (get-chatbot-name (get-system-chatbot-from-id some-system (get-message-chatbot some-message))) ": "
    (get-flow-name (get-chatbot-active-flow (get-system-chatbot-from-id some-system 
    (get-message-chatbot some-message)) (get-message-flow some-message))) "\n"
    (get-flow-options-format (get-chatbot-active-flow (get-system-chatbot-from-id some-system 
    (get-message-chatbot some-message)) (get-message-flow some-message)))))

;descripción:  Función que permite obtener sintesis de lo realizado por un usuario
;recursión: noot
;dom: system X message (string)
;rec: system
(define (system-synthesis some-system some-user)
  (if (null? (get-system-chatHistory some-system))
    (display "")
    (string-join (map (lambda (message) (get-message-display-format message some-system)) 
    (filter (lambda (chatHistory-message) (equal? (get-message-user chatHistory-message) some-user)) 
    (get-system-chatHistory some-system))) "\n\n")))

;descripción:  Función que permite obtener sintesis de lo realizado por un usuario
;recursión: no
;dom: system X message (string)
;rec: system
(define (system-simulate some-system n-interaccions seed)
  (define (system-simulate-rec some-system n-interaccions seed)
    (cond 
      ((zero? n-interaccions) some-system)
      ((zero? seed) some-system)
      ((equal? -1 (get-system-Activechatbotcodelink some-system)) some-system)
      (else (system-simulate-rec (system-talk some-system (number->string (remainder seed 10))) 
        (- n-interaccions 1) (myRandom seed)))))
  (system-simulate-rec (system-login (system-add-user 
    (system-logout some-system) (string-append "user" (number->string seed)))
    (string-append "user" (number->string seed))) n-interaccions seed))