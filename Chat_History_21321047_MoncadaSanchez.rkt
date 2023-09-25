#lang racket
(require "Date_21321047_MoncadaSanchez.rkt")

(provide (all-defined-out))

(define (make-message some-user some-chatbot some-message some-display-option ) 
    (list (make-date) some-user some-chatbot some-message some-display-option ))

(define (get-message-user some-message) (cadr some-message))