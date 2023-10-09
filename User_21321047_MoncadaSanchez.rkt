#lang racket

(provide (all-defined-out))

;CONSTRUCTORES
;descripción: Función que crea un usuario
;recursión: no
;dom: name(string)
;rec: user
(define (make-user name) (list name #f))

;descripción: Función que crea un nombre usuario base a una seed
;recursión: no
;dom: seed(number)
;rec: string
(define (make-user-name-by-seed some-seed) (string-append "user" (number->string some-seed)))

;Selectores
;descripción: Función que selecciona un nombre de un user
;recursión: no
;dom: user
;rec: string
(define (get-user-name some-user) (car some-user))

;descripción: Función que selecciona un estado de un user
;recursión: no
;dom: user
;rec: bool
(define (get-user-state some-user) (cadr some-user))

;descripción: Función que obtiene un usuario logeado
;recursión: no
;dom: user-list(list)
;rec: user
(define (get-login-user user-list)
  (car (filter (lambda (some-user) (equal? (get-user-state some-user) #t)) user-list)))

;MODIFICADORES
;descripción: Función que obtiene una nueva lista de usuarios con un user logeado
;recursión: Recursion Natural, debido a que se recorre la lista hasta encontrar el elemento a transformar
;dom: user-list(list) x user(string)
;rec: list
(define (set-login-user-list lst user)
  (cond 
    ((null? lst) '())
    ((equal? (get-user-name (car lst)) user)
     (cons (list (get-user-name (car lst)) #t) (cdr lst)))
    (else (cons (car lst) (set-login-user-list (cdr lst) user)))))

;descripción: Función que obtiene un lista de usuario con todos los usuarios offline
;recursión: Recursion Natural, debido a que se recorre la lista hasta encontrar el elemento a transformar
;dom: user-list(list)
;rec: list
(define (set-logout-user-list lst)
  (cond 
    ((null? lst) '())
    ((equal? (get-user-state (car lst)) #t)
     (cons (list (get-user-name (car lst)) #f) (cdr lst)))
    (else (cons (car lst) (set-logout-user-list (cdr lst))))))

;PERTENENCIA
;descripción: Función que verifica si un usuario esta logeado 
;recursión: no
;dom: user-list(list)
;rec: bool
(define (is-login-user user-lst) (member #t (map get-user-state user-lst)))