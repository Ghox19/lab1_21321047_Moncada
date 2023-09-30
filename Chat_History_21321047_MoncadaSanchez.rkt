#lang racket

(provide (all-defined-out))

(define (make-message some-user some-chatbot some-flow some-message) 
    (list (number->string (current-seconds)) some-user some-chatbot some-flow some-message))

(define (get-message-date some-message) (car some-message))

(define (get-message-user some-message) (cadr some-message))

(define (get-message-chatbot some-message) (caddr some-message))

(define (get-message-flow some-message) (cadddr some-message))

(define (get-message-user-message some-message) (car (cddddr some-message)))