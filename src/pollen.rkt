#lang racket

(require racket/list pollen/core pollen/decode txexpr gregor pollen/tag pollen/unstable/typography
         syntax/parse/define)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  #;(define command-char #\@))

(define (title . text)
  `(h1 ((class "header title")) ,@text))

(define (author . text)
  `(h5 ((class "header author")) ,@text))

(define (section . text)
  `(h3 ((class "section")) ,@text))

(define *book-counter* 0)
(define (book . title)
  (set! *book-counter* (+ *book-counter* 1))
  `(h2 ((class "book-heading"))
       (div
        (span ((class "book-counter")) ,(format "Book ~a: " *book-counter*))
        (span ((class "book-title")) ,@title))))

(define (saying intro . saying)
  `(div ((class "saying"))
        (span ((class "saying-intro")) ,intro)
        (blockquote ((class "saying-quote"))
                    ,@saying)))

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
                                       [("‘") (list '(squo-push) `(squo-pull ,str))]
                                       [("“") (list '(dquo-push) `(dquo-pull ,str))]
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
