(require (for-syntax syntax/parse))

(define-syntax define2
  (λ (stx)
     (syntax-parse stx
       [(_define2 var1 var2 expr)
        (syntax
          (begin
            (define var1 expr)
            (define var2 var1)))])))
