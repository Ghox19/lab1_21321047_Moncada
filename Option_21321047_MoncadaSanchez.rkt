#lang racket

;CONSTRUCTORES
;descripción: Función que crea opcion para flujo de un chatbot
;recursión: no
;dom: code (Int)  X message (String)  X ChatbotCodeLink (Int) X FlowCodeLink (Int) X Keyword* (en referencia a 0 o más palabras claves)
;rec: option
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (list code message ChatbotCodeLink FlowCodeLink Keyword))