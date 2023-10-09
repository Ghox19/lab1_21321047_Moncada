#lang racket
(require "Common_21321047_MoncadaSanchez.rkt")
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Option_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")
(require "Chat_History_21321047_MoncadaSanchez.rkt")
(require "System_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;descripción: Función que crea opcion para flujo de un chatbot
;recursión: no
;dom: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword*
;rec: option
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (list code message ChatbotCodeLink FlowCodeLink Keyword))

;descripción: Función que crea un flujo de un chatbot
;recursión: Recursion Natural en la funcion "eliminar-duplicados", debido a que es la mejor manera para filtrar cada elemento dentro de una lista
;dom: id (int) X name (String) X Option*
;rec: flow
(define (flow id name . option)
  (list id name (eliminar-duplicados option get-option-code)))

;descripción: Función que añade una opcion a un flujo
;recursión: no
;dom: flow X option
;rec: flow
(define (flow-add-option some-flow option)
  (if (null? (get-flow-option some-flow))
      (set-flow-new-option some-flow (insertar-final-lista option (get-flow-option some-flow)))
      (if (member (get-option-code option) (map get-option-code (get-flow-option some-flow)))
          (display "")
          (set-flow-new-option some-flow (insertar-final-lista option (get-flow-option some-flow))))))

;descripción: Función constructora de un chatbot
;recursión: Recursion Natural en la funcion "eliminar-duplicados", debido a que es la mejor manera para filtrar cada elemento dentro de una lista
;dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows* 
;rec: chatbot
(define (chatbot id name welcomeMessage startFlowId . flows)
  (list id name welcomeMessage startFlowId (eliminar-duplicados flows get-flow-id)))

;descripción: Función añadir flujos a un chatbot
;recursión: Recursion Natural en la funcion "rec-list-add", debido a que se solicita
;dom: chatbot X flow
;rec: chatbot
(define (chatbot-add-flow some-chatbot flow)
  (if (null? (get-chatbot-flows some-chatbot))
      (set-chatbot-new-flow some-chatbot (rec-list-add (get-chatbot-flows some-chatbot) flow))
      (if (member (get-flow-id flow) (map get-flow-id (get-chatbot-flows some-chatbot)))
          some-chatbot
          (set-chatbot-new-flow some-chatbot (rec-list-add (get-chatbot-flows some-chatbot) flow)))))

;descripción: Función constructora de un sistema con chatbots
;recursión: Recursion Natural en la funcion "eliminar-duplicados", debido a que es la mejor manera para filtrar cada elemento dentro de una lista
;dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;rec: system
(define (system name initialchatbotcodelink . chatbot)
  (if (null? chatbot)
    (list (current-seconds) (list name null null initialchatbotcodelink chatbot))
    (list (current-seconds) (list name null null initialchatbotcodelink initialchatbotcodelink 
    (get-chatbot-Initialflow (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) 
    initialchatbotcodelink)) chatbot))) (eliminar-duplicados chatbot get-chatbot-id)))))

;descripción: Función añade chatbots al sistema
;recursión: no
;dom: system X chatbot
;rec: system
(define (system-add-chatbot some-system chatbot)
  (if (member (get-chatbot-id chatbot) (map get-chatbot-id (get-system-chatbots some-system)))
    some-system
    (set-system-new-chatbot some-system (insertar-final-lista chatbot (get-system-chatbots some-system)))))

;descripción: Función añade un usuario al sistema
;recursión: no
;dom: system X user
;rec: system
(define (system-add-user some-system some-user)
  (if (null? (get-system-user some-system))
    (set-system-new-user some-system (insertar-final-lista (make-user some-user) (get-system-user some-system)))
    (if (member some-user (map get-user-name (get-system-user some-system)))
      some-system
      (set-system-new-user some-system (insertar-final-lista (make-user some-user) (get-system-user some-system))))))

;descripción: Función que permite iniciar una sesión en el sistema.
;recursión: Recursion Natural en la funcion "set-login-user-list", debido a la facilidad de recorrer una lista y actualizar un valor
;dom: system X user
;rec: system
(define (system-login some-system user)
  (if (is-login-user (get-system-user some-system))
    some-system
    (set-system-login some-system (set-login-user-list (get-system-user some-system) user))))

;descripción: Función que permite cerrar una sesión en el sistema.
;recursión: Recursion Natural en la funcion "set-logout-user-list", debido a la facilidad de recorrer una lista y actualizar un valor
;dom: system X user
;rec: system
(define (system-logout some-system)
  (if (is-login-user (get-system-user some-system))
    (set-system-logout some-system (set-logout-user-list (get-system-user some-system)) 
    (get-chatbot-Initialflow (car (filter (lambda (chatbot) (equal? (get-chatbot-id chatbot) 
    (get-system-initialchatbotcodelink some-system))) (get-system-chatbots some-system)))))
    some-system))

;descripción:  Función que permite interactuar con un chatbot.
;recursión: Recursion Natural en la funcion "get-system-option-from-message-rec", debido a que se solicita
;dom: system X message (string)
;rec: system
(define (system-talk-rec some-system message)
  (if (not (is-login-user (get-system-user some-system)))
  some-system
    (if (null? (get-system-option-from-message-rec some-system message))
      (set-system-notalk some-system (set-system-chatHistory-new-message-notalk some-system message))
      (set-system-talk-norec some-system 
        (get-option-ChatbotCodeLink (get-system-option-from-message-rec some-system message))
        (get-option-InitialFlowCodeLink (get-system-option-from-message-rec some-system message))
        (set-system-chatHistory-new-message some-system 
          (get-option-ChatbotCodeLink (get-system-option-from-message-rec some-system message))
          (get-option-InitialFlowCodeLink (get-system-option-from-message-rec some-system message))
          message)))))

;descripción:  Función que permite interactuar con un chatbot.
;recursión: no
;dom: system X message (string)
;rec: system
(define (system-talk-norec some-system message)
  (if (not (is-login-user (get-system-user some-system)))
    some-system
    (if (null? (get-system-option-from-message some-system message))
      (set-system-notalk some-system 
        (set-system-chatHistory-new-message-notalk some-system message))
      (set-system-talk-norec some-system 
        (get-option-ChatbotCodeLink (get-system-option-from-message some-system message))
        (get-option-InitialFlowCodeLink (get-system-option-from-message some-system message))
        (set-system-chatHistory-new-message some-system 
          (get-option-ChatbotCodeLink (get-system-option-from-message some-system message))
          (get-option-InitialFlowCodeLink (get-system-option-from-message some-system message))
          message)))))

;descripción:  Función que permite obtener sintesis de lo realizado por un usuario
;recursión: noot
;dom: system X message (string)
;rec: system
(define (system-synthesis some-system some-user)
  (if (null? (get-system-chatHistory some-system))
    null
    (string-join (map (lambda (message) (system-message-display-format message some-system)) 
    (filter (lambda (chatHistory-message) (equal? (get-message-user chatHistory-message) some-user)) 
    (get-system-chatHistory some-system))) "\n\n")))


;descripción:  Función que permite simular un diálogo entre dos chatbots del sistema.
;recursión: Recursion Natural en la funcion "system-simulate-rec", debido que se simplifica el uso de esta funcion dentro de otra
;dom: system X n-interaccions(number) x seed(number)
;rec: system
(define (system-simulate some-system n-interaccions seed) 
  (define (system-simulate-rec some-system n-interaccions seed)
  (if (zero? n-interaccions)
    some-system
    (system-simulate-rec (system-talk-norec some-system (number->string (remainder seed 10))) 
      (- n-interaccions 1) (myRandom seed))))
  (if (is-login-user (get-system-user some-system))
    (system-simulate-rec (system-login (system-add-user (system-logout some-system) 
      (make-user-name-by-seed seed)) (make-user-name-by-seed seed)) n-interaccions seed)
    (system-simulate-rec (system-login (system-add-user some-system 
      (make-user-name-by-seed seed)) (make-user-name-by-seed seed)) n-interaccions seed)))