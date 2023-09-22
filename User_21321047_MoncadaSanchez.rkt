#lang racket

(provide (all-defined-out))

(define (make-user name) (list name #f))

(define (get-user-name some-user) (car some-user))

(define (get-user-state some-user) (cadr some-user))

(define (get-login-user user-list)
  (car (filter (lambda (some-user) (equal? (get-user-state some-user) #t)) user-list)))

(define (get-login-user-list lst user)
  (cond 
    ((null? lst) '())
    ((equal? (get-user-name (car lst)) user)
     (cons (list (get-user-name (car lst)) #t) (cdr lst)))
    (else (cons (car lst) (get-login-user-list (cdr lst) user)))))

(define (get-logout-user-list lst)
  (cond 
    ((null? lst) '())
    ((equal? (get-user-state (car lst)) #t)
     (cons (list (get-user-name (car lst)) #f) (cdr lst)))
    (else (cons (car lst) (get-logout-user-list (cdr lst))))))

(define (is-login-user user-lst) (member #t (map get-user-state user-lst)))