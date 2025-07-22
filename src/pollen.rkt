#lang racket

(require racket/list pollen/core pollen/decode txexpr gregor pollen/tag pollen/unstable/typography
         syntax/parse/define)
(provide (all-defined-out))

(define *page-metadata* (make-hash))
(define *page-metadata/props* (make-hash))

(define (meta/keywords txt)
  (hash-set! *page-metadata* 'keywords txt)
  '(div))

(define (meta/prop prop-name txt)
  (hash-set! *page-metadata/props* prop-name txt)
  '(div))

(define (meta prop-name txt)
  (hash-set! *page-metadata* prop-name txt)
  '(div))

(define (metadata)
  #;`(meta ((keywords ,(hash-ref *page-metadata* 'keywords (λ () "")))))
  `(div
    ,@(hash-map *page-metadata* (λ (p v) `(meta ((name ,p) (content ,v)))))
    ,@(hash-map *page-metadata/props* (λ (p v) `(meta ((property ,p) (content ,v)))))
    (meta ((keywords ,(hash-ref *page-metadata* 'keywords (λ () "")))))
    ))

(define-syntax (inc! stx)
  (syntax-parse stx
    [(_ v:id) #'(set! v (+ 1 v))]))

(module setup racket/base
  (provide (all-defined-out))
  #;(define command-char #\@))

(define *book-counter* 0)
(define *section-counter* 0)

(define (title . text)
  (set! *book-counter* 0)
  `(h1 ((class "header title")) ,@text))

(define (author . text)
  `(h5 ((class "header author")) ,@text))

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

(define (book* . title)
  (inc! *book-counter*)
  (set! *section-counter* 0)
  (let ([anchor (format "b~a" *book-counter*)])
    `(h2 ((class "book-heading") (id ,anchor))
         (a ((href ,(format "#~a" anchor)))
          #;(span ((class "book-counter")) ,(format "Book ~a " *book-counter*))
          (span ((class "book-title")) ,@title)))))

;; used for Perlisms
(define *epigram-counter* 0)
#;(define (epigram . _)
  (inc! *epigram-counter*)
  (let ([anchor (format "e~a" *book-counter* *epigram-counter*)])
    `(h3 ((class "section-heading")
          (id ,anchor))
         (a ((href ,(format "#~a" anchor))) ,(format "~a" *epigram-counter*)))))
(define (epigram . text)
  (inc! *epigram-counter*)
  (let ([anchor (format "e~a" *epigram-counter*)])
    `(div ((class "epigram"))
          (h3 ((class "epigram-heading")
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

(define (verse . lines)
  `(div ((class "verse"))
        ,@(map (λ (l) `(div ((class "verse-line")) ,l)) lines)))

(define *note-counter* 0)
(define (inline-note . text)
  (inc! *note-counter*)
  (let ([popover-id (format "note-popover-~a" *note-counter*)])
    `(span ((class "inline-note"))
           (button ((class "note-counter") (popovertarget ,popover-id)) ,(format "[~a]" *note-counter*))
           (div ((class "note-contents") (popover "") (id ,popover-id))
                ,@text))))

(define (root . elements)
  (txexpr 'article empty
          (decode-elements elements
                           #:txexpr-elements-proc decode-paragraphs
                           #:exclude-tags '(code pre codeblock)
                           #:string-proc (compose1
                                          smart-quotes
                                          smart-dashes
                                          ;; wrap-hanging-quotes
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

(define (link url . text) `(a ((href ,url)) ,@text))

(define (it . text)
  `(span ((style "font-style: italic")) ,@text))

(define (itemize-nav . things)
  (let ([things (filter (λ (x) (not (and (string? x)
                                         (not (regexp-match #px"[[:graph:]]" x)))))
                        things)])
    `(nav
      (ul
       ,@(map (λ (i) `(li ,i)) things)))))

(define (make-toc elements)
  `(div ((class "toc"))
        (h4 () "Contents")
    (nav ((class "toc"))
       (ul ()
           ,@(map (λ (x) `(li () ,(link (format "#~a" x) `(pre ,(format "~a" x))))) elements)))))
