(require (for-syntax syntax/parse))

(define-syntax define2
  (λ (stx)
     (syntax-parse stx
       [(_define2 var1 var2 expr)
        (syntax
          (begin
            (define var1 expr)
            (define var2 var1)))])))

(define2 a b 42)

(define-syntax define3
  (lambda (stx)
    (syntax-parse stx
      [(_define3 v1 v2 v3 expr)
       (syntax
         (begin
           (define v1 expr)
           (define v2 v1)
           (define v3 v2)))])))

(define3 x y z 42)

(define m '())
(define n m)
(set! m (cons 'ok m))

(define m '())
(define n '())
(set! m (cons 'ok m))
