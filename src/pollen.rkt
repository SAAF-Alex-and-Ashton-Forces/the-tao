#lang racket

(require racket/list pollen/core pollen/decode txexpr gregor pollen/tag pollen/unstable/typography
         syntax/parse/define)
(provide (all-defined-out))

(define-syntax (inc! stx)
  (syntax-parse stx
    [(_ v:id) #'(set! v (+ 1 v))]))

(module setup racket/base
  (provide (all-defined-out))
  #;(define command-char #\@))

(define (title . text)
  `(h1 ((class "header title")) ,@text))

(define (author . text)
  `(h5 ((class "header author")) ,@text))

(define *book-counter* 0)
(define *section-counter* 0)

(define (book . title)
  (inc! *book-counter*)
  (set! *section-counter* 0)
  (let ([anchor (format "b~a" *book-counter*)])
    `(h2 ((class "book-heading") (id ,anchor))
         (a ((href ,(format "#~a" anchor)))
          ;; (span ((class "book-counter")) ,(format "Book ~a " *book-counter*))
          (span ((class "book-counter")) ,(format "Book ~a " *book-counter*))
          (span ((class "book-title")) ,@title)))))

(define (section . _)
  (inc! *section-counter*)
  (let ([anchor (format "s~a.~a" *book-counter* *section-counter*)])
    `(h3 ((class "section-heading")
          (id ,anchor))
         (a ((href ,(format "#~a" anchor))) ,(format "~a.~a" *book-counter* *section-counter*)))))

;; used for Perlisms
(define *epigram-counter* 0)
(define (epigram . text)
  (inc! *epigram-counter*)
  (let ([anchor (format "e~a" *epigram-counter*)])
    `(div ((class "epigram"))
          (h3 ((class "section-heading")
               (id ,anchor))
              (a ((href ,(format "#~a" anchor))) ,(format "~a" *epigram-counter*)))
          (p ((class "epigram-body"))
             ,@text))))

(define (saying intro . saying)
  `(div ((class "saying"))
        (span ((class "saying-intro")) ,intro)
        (blockquote ((class "saying-quote"))
                    ,@saying)))

(define (syllogism . lines)
  `(blockquote ((class "syllogism"))
        ,@(map (λ (l) `(div ((class "prop")) ,l)) lines)))

(define (cr call . response)
  `(div ((class "call-response"))
        (div ((class "call"))
              ,call)
        (div ((class "response"))
              ,@response)))

(define (root . elements)
  (txexpr 'root empty
          (decode-elements elements
                           #:txexpr-elements-proc decode-paragraphs
                           #:exclude-tags '(code pre codeblock)
                           #:string-proc (compose1
                                          #;make-quotes-hangable
                                          smart-quotes
                                          smart-dashes
                                          smart-ellipses))))

;; snarfed from https://docs.racket-lang.org/pollen-tfl/_pollen_rkt_.html#%28def._%28%28lib._pollen-tfl%2Fpollen..rkt%29._make-quotes-hangable%29%29
#;(define (make-quotes-hangable str)
  (define substrs (regexp-match* #px"\\s?[“‘]" str #:gap-select? #t))
  (if (= (length substrs) 1)
      (car substrs)
      (cons 'quo (append-map (λ (str)
                               (let ([strlen (string-length str)])
                                 (if (> strlen 0)
                                     (case (substring str (sub1 strlen) strlen)
                                       [("‘") (list '(squo-open-push) `(squo-open-pull ,str))]
                                       [("“") (list '(dquo-open-push) `(dquo-open-pull ,str))]
                                       [else (list str)])
                                     (list str)))) substrs))))

(define (details summary . body)
  `(details ()
            (summary () ,summary)
            ,@body))

(define (link url text) `(a ((href ,url)) ,text))

(define (make-toc elements)
  `(div ((class "toc"))
        (h4 () "Contents")
    (nav ((class "toc"))
       (ul ()
           ,@(map (λ (x) `(li () ,(link (format "#~a" x) `(pre ,(format "~a" x))))) elements)))))
