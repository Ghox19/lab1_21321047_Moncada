#lang racket
(require "Common_21321047_MoncadaSanchez.rkt")
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")
(require "Chat_History_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un mensaje de chatHistory sin exito de interaccion
;recursión: no
;dom: system x message(string)
;rec: list
(define (make-system-message-notalk some-system message)
  (make-message (get-user-name (get-login-user (get-system-user some-system))) 
    (get-chatbot-id (get-system-chatbot-by-id some-system (get-system-Activechatbotcodelink some-system))) 
    (get-system-Activeflowcodelink some-system) message))

;descripción: Función constructora de un mensaje de chatHistory con exito de interaccion
;recursión: no
;dom: system x activechatbotcode(number) x activeflowcode(number) x message(string)
;rec: list
(define (make-system-message-talk some-system activechatbotcode activeflowcode message)
  (make-message (get-user-name (get-login-user (get-system-user some-system))) 
    activechatbotcode activeflowcode message))

;SELECTORES
;descripción: Función que selecciona una fecha de creacion de un system
;recursión: no
;dom: system
;rec: number
(define (get-system-date some-system) (car some-system))

;descripción: Función que selecciona un nombre de un system
;recursión: no
;dom: system
;rec: string
(define (get-system-name some-system) (caadr some-system))

;descripción: Función que selecciona una lista de usuarios de un system
;recursión: no
;dom: system
;rec: list
(define (get-system-user some-system) (cadadr some-system))

;descripción: Función que selecciona el chatHistory de un system
;recursión: no
;dom: system
;rec: list
(define (get-system-chatHistory some-system) (cadr (cdadr some-system)))

;descripción: Función que selecciona un initialchatbotcodelink de un system
;recursión: no
;dom: system
;rec: number
(define (get-system-initialchatbotcodelink some-system) (caddr (cdadr some-system)))

;descripción: Función que selecciona un Activechatbotcodelink de un system
;recursión: no
;dom: system
;rec: number
(define (get-system-Activechatbotcodelink some-system) (cadddr (cdadr some-system)))

;descripción: Función que selecciona un Activeflowcodelink de un system
;recursión: no
;dom: system
;rec: number
(define (get-system-Activeflowcodelink some-system) (car (cddddr (cdadr some-system))))

;descripción: Función que selecciona una lista de chatbots de un system
;recursión: no
;dom: system
;rec: list
(define (get-system-chatbots some-system) (cadr (cddddr (cdadr some-system))))

;descripción: Función que selecciona un chatbot base a una id
;recursión: no
;dom: system x id-chatbot(number)
;rec: chatbot
(define (get-system-chatbot-by-id some-system id-chatbot) 
  (if(null? (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) id-chatbot))
  (get-system-chatbots some-system)))
    null
    (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) id-chatbot))
    (get-system-chatbots some-system)))))

;descripción: Función que selecciona una opcion desde el system base a un mensaje
;recursión: Recursion natural en la funcion "get-flow-option-from-message-rec", debido a que se solicita
;dom: system x message(string)
;rec: option
(define (get-system-option-from-message-rec some-system message) 
        (get-flow-option-from-message-rec (get-chatbot-flow-by-id 
        (get-system-chatbot-by-id some-system (get-system-Activechatbotcodelink some-system))
        (get-system-Activeflowcodelink some-system)) message))

;descripción: Función que selecciona una opcion desde el system base a un mensaje
;recursión: no
;dom: system x message(string)
;rec: option
(define (get-system-option-from-message some-system message) 
        (get-flow-option-from-message (get-chatbot-flow-by-id 
        (get-system-chatbot-by-id some-system (get-system-Activechatbotcodelink some-system))
        (get-system-Activeflowcodelink some-system)) message))

;MODIFICADORES
;descripción: Función que define un nuevo system con una nueva lista de chatbots
;recursión: no
;dom: system x chatbot-list(list)
;rec: system
(define (set-system-new-chatbot some-system chatbot-list) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        (get-system-user some-system) 
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        chatbot-list)))

;descripción: Función que define un nuevo system con una nueva lista de users
;recursión: no
;dom: system x user-list(list)
;rec: system
(define (set-system-new-user some-system user-list) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        user-list
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        (get-system-chatbots some-system))))

;descripción: Función que define un nuevo system con una nueva lista de users despues de un login
;recursión: no
;dom: system x user-list(list)
;rec: system
(define (set-system-login some-system user-list) 
  (list (get-system-date some-system) 
        (list (get-system-name some-system) 
        user-list
        (get-system-chatHistory some-system) 
        (get-system-initialchatbotcodelink some-system)
        (get-system-Activechatbotcodelink some-system)
        (get-system-Activeflowcodelink some-system)
        (get-system-chatbots some-system))))

;descripción: Función que define un nuevo system con una nueva lista de users despues de un logout
;recursión: no
;dom: system x user-list(list) x initial-flow(number)
;rec: system
(define (set-system-logout some-system user-list initial-flow) 
    (list (get-system-date some-system) 
          (list (get-system-name some-system) 
          user-list 
          (get-system-chatHistory some-system) 
          (get-system-initialchatbotcodelink some-system)
          (get-system-initialchatbotcodelink some-system)
          initial-flow
          (get-system-chatbots some-system))))

;descripción: Función que define un nuevo system tras un system-talk-norec con exito
;recursión: no
;dom: system x activechatbotcode(number) x activeflowcode(number) x chatHistory(list)
;rec: system
(define (set-system-talk-norec some-system activechatbotcode activeflowcode chatHistory) 
    (list (get-system-date some-system) 
          (list (get-system-name some-system) 
          (get-system-user some-system) 
          chatHistory
          (get-system-initialchatbotcodelink some-system)
          activechatbotcode
          activeflowcode
          (get-system-chatbots some-system))))

;descripción: Función que define un nuevo system tras un system-talk-norec sin exito
;recursión: no
;dom: system x chatHistory(list)
;rec: system
(define (set-system-notalk some-system chatHistory) 
    (list (get-system-date some-system) 
          (list (get-system-name some-system) 
          (get-system-user some-system) 
          chatHistory
          (get-system-initialchatbotcodelink some-system)
          (get-system-Activechatbotcodelink some-system)
          (get-system-Activeflowcodelink some-system)
          (get-system-chatbots some-system))))

;descripción: Función que define un nuevo chatHistory tras un system-talk-norec con exito
;recursión: no
;dom: system x activechatbotcode(number) x activeflowcode(number) x message(string)
;rec: list
(define (set-system-chatHistory-new-message some-system activechatbotcode activeflowcode message) 
        (insertar-final-lista (make-system-message-talk some-system activechatbotcode activeflowcode message)
          (get-system-chatHistory some-system)))

;descripción: Función que define un nuevo chatHistory tras un system-talk-norec sin exito
;recursión: no
;dom: system x message(string)
;rec: list
(define (set-system-chatHistory-new-message-notalk some-system message) 
        (insertar-final-lista (make-system-message-notalk some-system message)
          (get-system-chatHistory some-system)))

;OTRAS FUNCIONES
;descripción: Función que selecciona un mensaje del chatHistory y le genera un formato para display desde system
;recursión: no
;dom: message(list) x system
;rec: string
(define (system-message-display-format some-message some-system)
  (string-append 
    (get-message-date some-message) " - " (get-message-user some-message) ": "
    (get-message-user-message some-message) "\n"
    (get-message-date some-message) " - "
    (get-chatbot-name (get-system-chatbot-by-id some-system (get-message-chatbot some-message))) ": "
    (get-flow-name (get-chatbot-flow-by-id (get-system-chatbot-by-id some-system 
    (get-message-chatbot some-message)) (get-message-flow some-message))) "\n"
    (flow-options-format (get-chatbot-flow-by-id (get-system-chatbot-by-id some-system 
    (get-message-chatbot some-message)) (get-message-flow some-message)))))