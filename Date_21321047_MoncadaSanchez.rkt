#lang racket
(provide (all-defined-out))

(define (make-date)
  (let* ((current-seconds (current-seconds))
         (date (seconds->date current-seconds))
         (day (date-day date))
         (month (date-month date))
         (year (date-year date))
         (hour (date-hour date))
         (minute (date-minute date))
         (second (date-second date)))
    (string-append
     (if (< day 10) "0" "") (number->string day) "/"
     (if (< month 10) "0" "") (number->string month) "/"
     (number->string year) " "
     (if (< hour 10) "0" "") (number->string hour) ":"
     (if (< minute 10) "0" "") (number->string minute) ":"
     (if (< second 10) "0" "") (number->string second))))