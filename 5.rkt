#lang br

;; (define (to-syntax s [source-name #f])
;; ;;   (read-syntax source-name (open-input-string s)))

(define (to-syntax s [source-name #f])
  (define input (open-input-string s))
  (port-count-lines! input)
  (read-syntax source-name input))

;; (expand (to-syntax "(foo bar baz)"))

;; fact belongs to #%top - creates an association (#%top . fact)
;; =, etc, belong to #%app
(expand
  (syntax
    (define (fact n)
      (if (= n 0)
        1
        (* n (fact (sub1 n)))))))

;; (expand (syntax (lambda (n) (add1 n))))
