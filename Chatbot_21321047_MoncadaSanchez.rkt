#lang racket
(require "Flow_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))
;CONSTRUCTORES
;descripción: Función constructora de un chatbot
;recursión: si, para verificar si se repite algun id de un flow
;dom: chatbotID (int) X name (String) X welcomeMessage (String)  X  flows*
;rec: chatbot
(define (chatbot id name welcomeMessage . flows)
  (define (elementos-repetidos lst)
    (cond
      ((null? lst) #t)
      ((member (car lst) (cdr lst)) #f) 
      (else (elementos-repetidos (cdr lst)))))
  (if (elementos-repetidos (map get-flow-id flows))
    (list id name welcomeMessage flows)
    (display "")
  ))