#lang racket

;(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Option_21321047_MoncadaSanchez.rkt")
;(require "System_21321047_MoncadaSanchez.rkt")
;(require "Chat_History_21321047_MoncadaSanchez.rkt")

(define op1 (option  1 "1) Viajar" 2 4 "viajar" "turistear" "conocer") )
(define op2 (option  2 "2) Estudiar" 4 3 "aprender" "perfeccionarme"))

(define f10 (flow 1 "Flujo1" op1 op2))