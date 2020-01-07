#lang racket/base
;; ---------------------------------------------------------------------------------------------------

;; ---------------------------------------------------------------------------------------------------

(struct system-compiler (type path version))

;; Tries to find the current system C compiler by checking
;; CC and if not defined, trying gcc and clang
(define (find-compiler)
  (or (find-compiler/CC)
      (find-compiler/gcc)
      (find-compiler/clang)))

;; Tries to find compiler from CC environment variable
;; returns #false or instance of system-compiler if not found
(define (find-compiler/CC)
  (define CC (getenv "CC"))
  (define CC-path (if (absolute-path? CC)
                      CC
                      (find-executable-path CC)))


  (define version (read-version CC-path))
