(define source
  "(define fact
     (lambda (n)
       (if (zero? n)
         1
         (* n (fact (sub1 n))))))")

(define ns (make-base-namespace))
(parameterize ([current-namespace ns]
               [read-accept-compiled #t])
  (define input    (open-input-string source))
  (define before   (read-syntax "fact.rkt" input))
  (define after    (expand       before))
  (define compiled (compile      after))
  (define result   (eval         compiled))
  (define out      (list before
                         after
                         (substring (~a compiled) 0 20)
                         result))
  (for-each displayln out))
