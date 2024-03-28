;; https://soegaard.github.io/mythical-macros/#1.3

;; 4 passes
;; 1. read      s-expression [reader macros?]
;; 2. expand    #<syntax...>. expands macros
;; 3. compile   ...compiled
;; 4. eval      result

;; expansion macros happen @ compile time; can't change lex or initial parse
(require racket/format)

(define source
  "(begin
    (define (fact n)
      (cond
        [(= n 0) 1]
        [else
          (* n (fact (sub1 n)))]))
    (fact 5))")

(define ns (make-base-namespace))
(parameterize ([current-namespace ns]
               [read-accept-compiled #t])
  (define input    (open-input-string source))
  (define before   (read    input))
  (define after    (expand  before))
  (define compiled (compile after))
  (define result   (eval    compiled))
  (define out      (list "-- before expansion --"
                         before
                         "-- after expension --"
                         after
                         "-- compiled expression --"
                         (substring (~a compiled) 0 100)
                         "-- result --"
                         result))
  (for-each displayln out))
