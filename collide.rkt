;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname collide) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;;(build-sphere x y z r) Consumes values for a sphere and puts them in a list.
;;Examples
(check-expect (build-sphere (cons 0 (cons 1 (cons 2 (cons 5 empty)))))
              (cons (cons 0 (cons 1 (cons 2 empty))) (cons 5 empty)))
(check-expect (build-sphere (cons 1 (cons 4 (cons 3 (cons 6 empty)))))
              (cons (cons 1 (cons 4 (cons 3 empty))) (cons 6 empty)))
;;build-sphere (Int Int Int Nat)--> (listof Int)

(define (build-sphere lon)
  (cons (cons (first lon) (cons (first (rest lon)) (cons (first (rest (rest lon))) empty)))
        (cons (first (rest (rest (rest lon)))) empty)))

(check-expect (build-sphere (cons 9 (cons -5 (cons 3 (cons 68 empty)))))
              (cons (cons 9 (cons -5 (cons 3 empty))) (cons 68 empty)))

;;(valid-sphere? loi) checks if the radius is greater than 0.
;;Examples
(check-expect (valid-sphere? (cons (cons 0 (cons 1 (cons 2 empty))) (cons 5 empty))) true)
(check-expect (valid-sphere? (cons (cons 1 (cons 2 (cons 3 empty))) (cons -1 empty))) false)
;;valid-sphere? (listof Int)--> Bool

(define minimum-radius 0)

(define (valid-sphere? lon)
  (cond [(> (first (rest lon)) minimum-radius) true]
        [else false]))

(check-expect (valid-sphere? (cons (cons 1 (cons 2 (cons 3 empty))) (cons 0 empty))) false)

;;(distance-between-points lon1 lon2) given two point it produces the distance between them.
;;Examples
(check-within (distance-between-points (cons 0 (cons 0 (cons 0 empty)))
                                       (cons 1 (cons 1 (cons 1 empty)))) (sqrt 3) 0.01)
(check-within (distance-between-points (cons 1 (cons 2 (cons 3 empty)))
                                       (cons 5 (cons 4 (cons 3 empty)))) (sqrt 20) 0.01)
;;distance-between-points ((listof Int) (listof Int))--> Num

(define (distance-between-points point1 point2)
  (sqrt (+ (sqr (- (first point2) (first point1))) (sqr (- (first (rest point2)) (first (rest point1))))
            (sqr (- (first (rest (rest point2))) (first (rest (rest point1))))))))

(check-expect (distance-between-points (cons 9 (cons 7 (cons 3 empty)))
                                       (cons 5 (cons 4 (cons 3 empty)))) 5)

;;(point-in-sphere? loi loi)consumes a point and sphere and determines if the point is inside the sphere.
;;Examples
(check-expect (point-in-sphere? (cons 1 (cons 1 (cons 1 empty)))
                                (cons (cons 0 (cons 0 (cons 0 empty))) (cons 5 empty))) true)
(check-expect (point-in-sphere? (cons 9 (cons 14 (cons 10 empty)))
                                (cons (cons 2 (cons 1 (cons 0 empty))) (cons 2 empty))) false)
;;point-in-sphere? ((listof Int) (listof Int))--> Bool

(define (point-in-sphere? point sphere)
  (cond [(<= (distance-between-points point (first sphere)) (first (rest sphere))) true]
        [else false]))

(check-expect (point-in-sphere? (cons 3 (cons 4 (cons 0 empty)))
                                (cons (cons 0 (cons 0 (cons 0 empty))) (cons 5 empty))) true)
(check-expect (point-in-sphere? (cons 1 (cons 1 (cons 1 empty)))
                                (cons (cons 0 (cons 0 (cons 0 empty))) (cons 5 empty))) true)


;;(collide? loi loi) consumes two spheres and determines if they collide.
;;Examples
(check-expect (collide? (cons (cons 1 (cons 1 (cons 1 empty))) (cons 2 empty))
                        (cons (cons 0 (cons 0 (cons 0 empty))) (cons 5 empty))) true)
(check-expect (collide? (cons (cons 19 (cons 14 (cons 5 empty))) (cons 2 empty))
                        (cons (cons 0 (cons 0 (cons 0 empty))) (cons 3 empty))) false)
;;collide? ((listof Int) (listof Int))--> Bool
  
(define (collide? sphere1 sphere2)
  (<= (distance-between-points (first sphere1) (first sphere2))
      (+ (first (rest sphere1)) (first (rest sphere2)))))

(check-expect (collide? (cons (cons 0 (cons 0 (cons 0 empty)))
                                      (cons 2 empty)) (cons (cons 0 (cons 0 (cons 7 empty))) (cons 5 empty))) true)
