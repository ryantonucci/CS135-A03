;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rgb) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;;(RGB->name lon) Takes a list of RGB values and converts it into symbols which denote colour.
;;Examples:
(check-expect (RGB->name (cons 255 (cons 0 (cons 0 empty)))) 'red)
(check-expect (RGB->name (cons 255 (cons 255 (cons 255 empty)))) 'white)
;;RGB->name (listof Nat)-> Sym

(define max-RGB-value 255)
(define min-RGB-value 0)

(define (RGB->name lon)
  (cond [(= (first lon) max-RGB-value)  ;tests if the first value is 255
         (cond [(= (first (rest lon)) max-RGB-value) ;tests if the second value is 255
                (cond [(= (first (rest (rest lon))) max-RGB-value) 'white]  ;tests if the third value is 255
                      [(= (first (rest (rest lon))) min-RGB-value) 'yellow]
                      [else 'unknown])]  ;tests if 3rd val is 0
               [(= (first (rest lon)) min-RGB-value)  ;tests if 2nd value is 0
                (cond [(= (first (rest (rest lon))) max-RGB-value) 'magenta]  ;tests if 3rd val is 255
                      [(= (first (rest (rest lon))) min-RGB-value) 'red]
                      [else 'unknown])]
               [else 'unknown])]  ;tests if 3rd val is 0
        [(= (first lon) min-RGB-value)
         (cond [(= (first (rest lon)) max-RGB-value) ;tests if the second value is 255
                (cond [(= (first (rest (rest lon))) max-RGB-value) 'cyan]  ;tests if the third value is 255
                      [(= (first (rest (rest lon))) min-RGB-value) 'green]
                      [else 'unknown])]  ;tests if 3rd val is 0
               [(= (first (rest lon)) min-RGB-value)  ;tests if 2nd value is 0
                (cond [(= (first (rest (rest lon))) max-RGB-value) 'blue]  ;tests if 3rd val is 255
                      [(= (first (rest (rest lon))) min-RGB-value) 'black]
                      [else 'unknown])] ;tests if 3rd val is 0]
               [else 'unknown])] 
        [else 'unknown])) 
                                                   

(check-expect (RGB->name (cons 255 (cons 0 (cons 255 empty)))) 'magenta)
(check-expect (RGB->name (cons 255 (cons 255 (cons 0 empty)))) 'yellow)
(check-expect (RGB->name (cons 0 (cons 255 (cons 255 empty)))) 'cyan)
(check-expect (RGB->name (cons 0 (cons 255 (cons 0 empty)))) 'green)
(check-expect (RGB->name (cons 0 (cons 0 (cons 255 empty)))) 'blue)
(check-expect (RGB->name (cons 0 (cons 0 (cons 0 empty)))) 'black)
(check-expect (RGB->name (cons 0 (cons 255 (cons 9 empty)))) 'unknown)

;;(name->RGB Sym)  takes the name of the colour and converts it to a RGB code.
;;Examples:
(check-expect (name->RGB 'red) (cons 255 (cons 0 (cons 0 empty))))
(check-expect (name->RGB 'white) (cons 255 (cons 255 (cons 255 empty))))
;;name->RGB Sym-> (listof Nat)

(define (name->RGB colour)
  (cond [(symbol=? colour 'red) (cons max-RGB-value (cons min-RGB-value
                                                          (cons min-RGB-value empty)))]
        [(symbol=? colour 'green) (cons min-RGB-value (cons max-RGB-value
                                                            (cons min-RGB-value empty)))]
        [(symbol=? colour 'blue) (cons min-RGB-value (cons min-RGB-value
                                                           (cons max-RGB-value empty)))]
        [(symbol=? colour 'black) (cons min-RGB-value (cons min-RGB-value
                                                            (cons min-RGB-value empty)))]
        [(symbol=? colour 'white) (cons max-RGB-value (cons max-RGB-value
                                                            (cons max-RGB-value empty)))]
        [(symbol=? colour 'yellow) (cons max-RGB-value (cons max-RGB-value
                                                             (cons min-RGB-value empty)))]
        [(symbol=? colour 'magenta) (cons max-RGB-value (cons min-RGB-value
                                                              (cons max-RGB-value empty)))]
        [(symbol=? colour 'cyan) (cons min-RGB-value (cons max-RGB-value
                                                           (cons max-RGB-value empty)))]
        [else (cons -1 (cons -1 (cons -1 empty)))]))

(check-expect (name->RGB 'green) (cons 0 (cons 255 (cons 0 empty))))
(check-expect (name->RGB 'blue) (cons 0 (cons 0 (cons 255 empty))))
(check-expect (name->RGB 'black) (cons 0 (cons 0 (cons 0 empty))))
(check-expect (name->RGB 'yellow) (cons 255 (cons 255 (cons 0 empty))))
(check-expect (name->RGB 'magenta) (cons 255 (cons 0 (cons 255 empty))))
(check-expect (name->RGB 'cyan) (cons 0 (cons 255 (cons 255 empty))))
(check-expect (name->RGB 'purple) (cons -1 (cons -1 (cons -1 empty))))

;;(RGB->luminosity lon) converts an RGB code to grayscale value.
;;Examples:
(check-expect (RGB->luminosity (cons 255 (cons 0 (cons 0 empty)))) 76.5)
(check-expect (RGB->luminosity (cons 255 (cons 255 (cons 255 empty)))) 255)
;;RGB->luminosity (listof Nat)-> Num

(define luminosity-for-red 0.3)
(define luminosity-for-green 0.59)
(define luminosity-for-blue 0.11)

(define (RGB->luminosity lon)
  (+ (* luminosity-for-red (first lon)) (* luminosity-for-green (first (rest lon)))
     (* luminosity-for-blue (first (rest (rest lon))))))

(check-expect (RGB->luminosity (cons 45 (cons 65 (cons 200 empty)))) 73.85)
(check-expect (RGB->luminosity (cons 119 (cons 97 (cons 7 empty)))) 93.7)

;;(valid-RGB? Any) checks if a list of 3 natural numbers from 0 to 255 is provided.
;;Examples:
(check-expect (valid-RGB? 'red) false)
(check-expect (valid-RGB? (cons 255 (cons 0 (cons 0 empty)))) true)
;;valid-RGB? (Any--> Bool)

(define (valid-RGB? Any)
  (cond [(and (cons? Any)
                (= (length Any) 3)
                (= (first Any) (floor (first Any)))
                   (= (first (rest Any)) (floor (first (rest Any))))
                   (= (first (rest (rest Any))) (floor (first (rest (rest Any)))))
                   (>= (first Any) min-RGB-value)
                   (>= (first (rest Any)) min-RGB-value)
                   (>= (first (rest (rest Any))) min-RGB-value)
                   (<= (first Any) max-RGB-value)
                   (<= (first (rest Any)) max-RGB-value)
                   (<= (first (rest (rest Any))) max-RGB-value)) true]
         [else false]))
        

(check-expect (valid-RGB? (cons 256 (cons 5 (cons 6 empty)))) false)
(check-expect (valid-RGB? (cons 111 (cons 49 (cons 6 empty)))) true)
(check-expect (valid-RGB? (cons 100.4 (cons 49 (cons 6 empty)))) false)

;;(RGB->hex lon) changes from RGB code to hex code.
;;Examples:
(check-expect (RGB->hex (cons 255 (cons 0 (cons 0 empty))))
              (cons "F" (cons "F" (cons "0" (cons "0" (cons "0" (cons "0" empty)))))))
(check-expect (RGB->hex (cons 255 (cons 255 (cons 0 empty))))
              (cons "F" (cons "F" (cons "F" (cons "F" (cons "0" (cons "0" empty)))))))
;;RGB->hex (listof Nat)--> (listof Str)

(define base-16 16)

(define (RGB->hex lon)
  (cons (num->hex-element (quotient (first lon) base-16))
        (cons (num->hex-element (remainder (first lon) base-16))
              (cons (num->hex-element (quotient (first (rest lon)) base-16))
                    (cons (num->hex-element (remainder (first (rest lon)) base-16))
                          (cons (num->hex-element (quotient (first (rest (rest lon))) base-16))
                                (cons (num->hex-element (remainder (first (rest (rest lon)))
                                                                   base-16)) empty)))))))

                          
;;(num->hex-element Num) is to convert the quotient or remainder into hex code
;;Examples:
(check-expect (num->hex-element 5) "5")
(check-expect (num->hex-element 11) "B")
;;num->hex-element Num --> Num OR Str

(define (num->hex-element Num)
  (cond [(and (>= Num 0) (<= Num 9)) (number->string Num)]
        [(>= Num 10) (cond [(= Num 10) "A"]
                           [(= Num 11) "B"]
                           [(= Num 12) "C"]
                           [(= Num 13) "D"]
                           [(= Num 14) "E"]
                           [(= Num 15) "F"])]))