#lang racket
(require "Main_21321047_MoncadaSanchez.rkt")
(require "Common_21321047_MoncadaSanchez.rkt")
(require "Chatbot_21321047_MoncadaSanchez.rkt")
(require "Flow_21321047_MoncadaSanchez.rkt")
(require "Option_21321047_MoncadaSanchez.rkt")
(require "User_21321047_MoncadaSanchez.rkt")
(require "Chat_History_21321047_MoncadaSanchez.rkt")
(require "System_21321047_MoncadaSanchez.rkt")

;; SCRIPT DE PRUEBA ENTREGADO EN EL ENUNCIADO
;Chabot0
(define op1 (option  1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2 y op1
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada            
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10))  ;solo añade una ocurrencia de f10
;Chatbot1
(define op3 (option 1 "1) New York, USA" 1 2 "USA" "Estados Unidos" "New York"))
(define op4 (option 2 "2) París, Francia" 1 1 "Paris" "Eiffel"))
(define op5 (option 3 "3) Torres del Paine, Chile" 1 1 "Chile" "Torres" "Paine" "Torres Paine" "Torres del Paine"))
(define op6 (option 4 "4) Volver" 0 1 "Regresar" "Salir" "Volver"))
;Opciones segundo flujo Chatbot1
(define op7 (option 1 "1) Central Park" 1 2 "Central" "Park" "Central Park"))
(define op8 (option 2 "2) Museos" 1 2 "Museo"))
(define op9 (option 3 "3) Ningún otro atractivo" 1 3 "Museo"))
(define op10 (option 4 "4) Cambiar destino" 1 1 "Cambiar" "Volver" "Salir")) 
(define op11 (option 1 "1) Solo" 1 3 "Solo")) 
(define op12 (option 2 "2) En pareja" 1 3 "Pareja"))
(define op13 (option 3 "3) En familia" 1 3 "Familia"))
(define op14 (option 4 "4) Agregar más atractivos" 1 2 "Volver" "Atractivos"))
(define op15 (option 5 "5) En realidad quiero otro destino" 1 1 "Cambiar destino"))
(define f20 (flow 1 "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?" op3 op4 op5 op6))
(define f21 (flow 2 "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?" op7 op8 op9 op10))
(define f22 (flow 3 "Flujo 3 Chatbot1\n¿Vas solo o acompañado?" op11 op12 op13 op14 op15))
(define cb1 (chatbot 1 "Agencia Viajes"  "Bienvenido\n¿Dónde quieres viajar?" 1 f20 f21 f22))
;Chatbot2
(define op16 (option 1 "1) Carrera Técnica" 2 1 "Técnica"))
(define op17 (option 2 "2) Postgrado" 2 1 "Doctorado" "Magister" "Postgrado"))
(define op18 (option 3 "3) Volver" 0 1 "Volver" "Salir" "Regresar"))

(define f30 (flow 1 "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?" op16 op17 op18))
(define cb2 (chatbot 2 "Orientador Académico"  "Bienvenido\n¿Qué te gustaría estudiar?" 1 f30))
;Sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0 cb1 cb2))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8"))
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))
;las siguientes interacciones deben funcionar de igual manera con system-talk-rec  o system-talk-norec-norec 
(define s11 (system-talk-rec s10 "hola"))
(define s12 (system-talk-rec s11 "1"))
(define s13 (system-talk-rec s12 "1"))
(define s14 (system-talk-rec s13 "Museo"))
(define s15 (system-talk-rec s14 "1"))
(define s16 (system-talk-rec s15 "3"))
(define s17 (system-talk-rec s16 "5"))
(display (system-synthesis s17 "user2"))
(display (system-synthesis (system-simulate s0 5 312321) "user312321"))

;; PRUEBA DE FUNCIONES
; RF 1 -> option
(define op01 (option  1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op02 (option  2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))
(define op03 (option 1 "1) New York, USA" 1 2 "USA" "Estados Unidos" "New York"))

; RF 2 -> flow

(define f1 (flow 1 "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?" op01 op01 op02 op01))
(define f2 (flow 2 "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?" op01 op02 op03))
(define f3 (flow 3 "Flujo 3 Chatbot1\n¿Vas solo o acompañado?"))

; RF 3 -> flow-add-option

(define f4 (flow-add-option f1 op01)) 
(define f5 (flow-add-option f3 op01))    
(define f6 (flow-add-option f5 op02)) 

; RF 4 -> chatbot

(define cb01 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f1 f1 f1 f1)) 
(define cb02 (chatbot 1 "Agencia Viajes"  "Bienvenido\n¿Dónde quieres viajar?" 1 f2 f6))
(define cb03 (chatbot 2 "Orientador Académico"  "Bienvenido\n¿Qué te gustaría estudiar?" 1 f5 f5 f1))

; RF 5 -> chatbot-add-flow

(define cb04 (chatbot-add-flow cb01 f2))
(define cb05 (chatbot-add-flow cb04 f1))
(define cb06 (chatbot-add-flow cb02 f1))

; RF 6 -> system

(define s01 (system "Chatbots Paradigmas1" 0 cb01))
(define s02 (system "Chatbots Paradigmas2" 0 cb01 cb01 cb02))
(define s03 (system "Chatbots Paradigmas3" 0 cb05 cb06))

; RF 7 -> system-add-chatbot

(define s04 (system-add-chatbot s01 cb06))
(define s05 (system-add-chatbot s04 cb01)) 
(define s06 (system-add-chatbot s05 cb03))

; RF 8 -> system-add-user

(define s07 (system-add-user s06 "user1"))
(define s08 (system-add-user s07 "user1")) 
(define s09 (system-add-user s08 "user2"))

; RF 9 -> system-login

(define s010 (system-login s09 "user1"))
(define s011 (system-login s010 "user1")) 
(define s012 (system-login s011 "user2")) 

; RF 10 -> system-logout

(define s013 (system-logout s012))
(define s014 (system-logout s013)) 
(define s015 (system-login s014 "user2"))
(define s016 (system-logout s015)) 

; RF 11 -> system-talk-rec

(define s017 (system-talk-rec s012 "1"))
(define s018 (system-talk-rec s016 "3")) 
(define s019 (system-talk-rec s017 "5")) 

; RF 12 -> system-talk-norec

(define s020 (system-talk-norec s012 "1"))
(define s021 (system-talk-norec s016 "3")) 
(define s022 (system-talk-norec s017 "5")) 

; RF 13 -> system-synthesis
(display "\n\nEjemplo RF13 1\n\n")
(display (system-synthesis s020 "user1"))
(display "\n\nEjemplo RF13 2\n\n")
(display (system-synthesis s021 "user1")) 
(display "\n\nEjemplo RF13 3\n\n")
(display (system-synthesis s022 "user2")) 

; RF 14 -> system-simulate 

(display "\n\nEjemplo RF14 1\n\n")
(display (system-synthesis (system-simulate s0 5 24) "user24"))
(display "\n\nEjemplo RF14 2\n\n")
(display (system-synthesis (system-simulate s0 5 7246) "user7246"))
(display "\n\nEjemplo RF14 3\n\n")
(display (system-synthesis (system-simulate s0 5 82345) "user82345"))