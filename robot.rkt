;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname robot) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; x-coordinate is an Int in the range [0, 10] representing the robot's horizontal position.
;; y-coordinate is an Int in the range [0, 10] representing the robot's vertical position.
;; direction is a Sym which shows the direction the robot is facing
;;    'North 'East "South or 'West

(define (State x-coordinate y-coordinate direction)
  (cons x-coordinate (cons y-coordinate (cons direction empty))))

(define move 1)
(define maximum 10)
(define minimum 0)

;;(robot-ctl loa command) takes a state and command and give a new state back.
;;Examples
(check-expect (robot-ctl (State 0 10 'South) 'forward) (cons 0 (cons 9 (cons 'South empty))))
(check-expect (robot-ctl (State 0 0 'North) 'turn-left) (cons 0 (cons 0 (cons 'West empty))))
;;robot-ctl (listof Any Sym)--> (listof Any)
               
(define (robot-ctl State command)
  (cond [(symbol=? command 'forward)
         (cond [(and (symbol=? (first (rest (rest State))) 'North) (< (first (rest State)) maximum)) 
                (cons (first State) (cons (+ (first (rest State )) move)
                                          (cons (first (rest (rest State))) empty)))]
               [(and (symbol=? (first (rest (rest State))) 'South)
                     (> (first (rest State)) minimum))
                (cons (first State) (cons (- (first (rest State )) move)
                                          (cons (first (rest (rest State))) empty)))]
               [(and (symbol=? (first (rest (rest State))) 'West) (> (first State) minimum))
                (cons (- (first State) move) (cons (first (rest State))
                                                   (cons (first (rest (rest State))) empty)))]
               [(and (symbol=? (first (rest (rest State))) 'East)
                     (< (first State) maximum))
                (cons (+ (first State) move) (cons (first (rest State))
                                                   (cons (first (rest (rest State))) empty)))]
               [else (cons (first State) (cons (first (rest State)) (cons
                                                                     (first (rest (rest State))) empty)))])]
        [(symbol=? command 'turn-left)
         (cond [(symbol=? (first (rest (rest State))) 'North)
                (cons (first State) (cons (first (rest State)) (cons 'West empty)))]
               [(symbol=? (first (rest (rest State))) 'West)
                (cons (first State) (cons (first (rest State)) (cons 'South empty)))]
               [(symbol=? (first (rest (rest State))) 'South)
                (cons (first State) (cons (first (rest State)) (cons 'East empty)))]
               [else (cons (first State) (cons (first (rest State)) (cons 'North empty)))])]
        [(symbol=? command 'turn-right)
         (cond [(symbol=? (first (rest (rest State))) 'North)
                (cons (first State) (cons (first (rest State)) (cons 'East empty)))]
               [(symbol=? (first (rest (rest State))) 'East)
                (cons (first State) (cons (first (rest State)) (cons 'South empty)))]
               [(symbol=? (first (rest (rest State))) 'South)
                (cons (first State) (cons (first (rest State)) (cons 'West empty)))]
               [else (cons (first State) (cons (first (rest State)) (cons 'North empty)))])]))
               
                                             
(check-expect (robot-ctl (cons 0 (cons 0 (cons 'North empty))) 'forward)
              (cons 0 (cons 1 (cons 'North empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'South empty))) 'forward)
              (cons 2 (cons 1 (cons 'South empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'East empty))) 'forward)
              (cons 3 (cons 2 (cons 'East empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'West empty))) 'forward)
              (cons 1 (cons 2 (cons 'West empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'North empty))) 'turn-left)
              (cons 2 (cons 2 (cons 'West empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'West empty))) 'turn-left)
              (cons 2 (cons 2 (cons 'South empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'South empty))) 'turn-left)
              (cons 2 (cons 2 (cons 'East empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'East empty))) 'turn-left)
              (cons 2 (cons 2 (cons 'North empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'North empty))) 'turn-right)
              (cons 2 (cons 2 (cons 'East empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'East empty))) 'turn-right)
              (cons 2 (cons 2 (cons 'South empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'South empty))) 'turn-right)
              (cons 2 (cons 2 (cons 'West empty))))
(check-expect (robot-ctl (cons 2 (cons 2 (cons 'West empty))) 'turn-right)
              (cons 2 (cons 2 (cons 'North empty))))
(check-expect (robot-ctl (cons 8 (cons 10 (cons 'North empty))) 'forward)
              (cons 8 (cons 10 (cons 'North empty))))