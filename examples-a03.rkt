;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname examples-a03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;;Purpose (RGB->name lon) Takes a list of RGB values and converts it into symbols which denote colour.
;;Examples
(check-expect (RGB->name (cons 255 (cons 0 (cons 0 empty)))) 'red)
(check-expect (RGB->name (cons 255 (cons 255 (cons 255 empty)))) 'white)
;;RGB->name (listof Nat)--> Sym

;;Purpose (name->RGB Sym)  takes the name of the colour and converts it to a RGB code.
;;Examples
(check-expect (name->RGB 'red) (cons 255 (cons 0 (cons 0 empty))))
(check-expect (name->RGB 'white) (cons 255 (cons 255 (cons 255 empty))))
;;name->RGB Sym--> (listof Nat)

;;Purpose (RGB->luminosity lon) converts an RGB code to grayscale value.
;;Examples
(check-expect (RGB->luminosity (cons 255 (cons 0 (cons 0 empty)))) 76.5)
(check-expect (RGB->luminosity (cons 255 (cons 255 (cons 255 empty)))) 255)
;;RGB->luminosity (listof Nat)--> Num

;;Purpose (valid-RGB? Any) checks if a list of 3 natural numbers from 0 to 255 is provided.
;;Examples
(check-expect (valid-RGB? 'red) false)
(check-expect (valid-RGB? (cons 255 (cons 0 (cons 0 empty)))) true)
;;valid-RGB (Any--> Bool)

;;Purpose (RGB->hex lon) changes from RGB code to hex code.
;;Examples
(check-expect (RGB->hex (cons 255 (cons 0 (cons 0 empty))))
              (cons "F" (cons "F" (cons "0" (cons "0" (cons "0" (cons "0" empty)))))))
(check-expect (RGB->hex (cons 255 (cons 255 (cons 0 empty))))
              (cons "F" (cons "F" (cons "F" (cons "F" (cons "0" (cons "0" empty)))))))
;;RGB->hex (listof Nat)--> (listof Str)

;;Purpose (robot-state x-coordinate y-coordinate direction) given state puts it in a list.
;;Examples
(check-expect (robot-state 0 0 'South) (cons 0 (cons 0 (cons 'South empty))))
(check-expect (robot-state 5 5 'West) (cons 5 (cons 5 (cons 'West empty))))
;;robot-state (Nat Nat Sym)--> (listof Any)

;;Purpose (robot-ctl loa command) takes a state and command and give a new state back.
;;Examples
(check-expect (robot-ctl (robot-state 0 10 'South) 'forward) ((robot-state 0 9 'South)))
(check-expect (robot-ctl (robot-state 0 0 'North) 'turn-left) ((robot-state 0 0 'West)))
;;robot-ctl (listof Any Sym)--> (listof Any)

;;Purpose (build-sphere x y z r) Consumes values for a sphere and puts them in a list.
;;Examples
(check-expect (build-sphere (0 1 2 5) (cons 0 (cons 1 (cons 2 (cons 5 empty))))))
(check-expect (build-sphere (1 4 3 6) (cons 1 (cons 4 (cons 3 (cons 6 empty))))))
;;build-sphere (Int Int Int Nat)--> (listof Int)

;;Purpose (valid-sphere? loi) checks if the radius is greater than 0.
;;Examples
(check-expect (valid-sphere? (cons 0 (cons 1 (cons 3 (cons 5 empty))))) true)
(check-expect (valid-sphere? (cons 0 (cons 1 (cons 2 (cons -1 empty))))) false)
;;valid-sphere? (listof Int)--> Bool

;;Purpose (distance-between-points loi loi) given two point it produces the distance between them.
;;Examples
(check-expect (distance-between-points ((cons 0 (cons 0 (cons 0 empty))) (cons 1 (cons 1 (cons 1 empty))))) (sqrt 3))
(check-expect (distance-between-points ((cons 1 (cons 2 (cons 3 empty))) (cons 5 (cons 4 (cons 3) empty)))) (sqrt 20))
;;distance-between-points ((listof Int) (listof Int))--> Num

;;Purpose (point-in-sphere? loi loi)consumes a point and sphere and determines if the point is inside the sphere.
;;Examples
(check-expect (point-in-sphere? (cons 1 (cons 1 (cons 1 empty))) (cons 0 (cons 0 (cons 0 (cons 5 empty))))) true)
(check-expect (point-in-sphere? (cons 9 (cons 14 (cons 10 empty))) (cons 2 (cons 1 (cons 0 (cons 3 empty))))) false)
;;point-in-sphere? ((listof Int) (listof Int))--> Bool

;;Purpose (collide? loi loi) consumes two spheres and determines if they collide.
;;Examples
(check-expect (point-in-sphere? (cons 1 (cons 1 (cons 1 (cons 2 empty)))) (cons 0 (cons 0 (cons 0 (cons 5 empty))))) true)
(check-expect (point-in-sphere? (cons 19 (cons 15 (cons 11 (cons 3 empty)))) (cons 0 (cons 0 (cons 0 (cons 5 empty))))) false)
;;collide? ((listof Int) (listof Int))--> Bool