(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)

(assert (< 0 A))
(assert (< 0 B))
(assert (< 0 C))
(assert (< 0 D))

;(assert
;  (forall ((w Int))
;    (implies
;      (<= 1 w 8)
;      (exists ((a Int) (b Int) (c Int) (d Int))
;        (and
;          (<= -1 a 1)
;          (<= -1 b 1)
;          (<= -1 c 1)
;          (<= -1 d 1)
;          (or (= a 1) (= b 1) (= c 1) (= d 1))
;          (= 
;            (+ 
;              (* A a) 
;              (* B b) 
;              (* C c) 
;              (* D d)
;            ) 
;            w
;          )
;        )
;      )
;    )
;  )
;)

(assert
  (forall ((w Int))
    (implies
      (<= 1 w 40)
      (or
        ; all 4
        (= (+ A B C D) w)

        (= (+ A B C) (+ w D))
        (= (+ A B D) (+ w C))
        (= (+ A C D) (+ w B))
        (= (+ B C D) (+ w A))
   
        (= (+ A B) (+ w C D))
        (= (+ A C) (+ w B D))
        (= (+ A D) (+ w B C))
        (= (+ B C) (+ w A D))
        (= (+ B D) (+ w A C))
        (= (+ C D) (+ w A B))
   
        (= A (+ w B C D))
        (= B (+ w A C D)) 
        (= C (+ w A B D))
        (= D (+ w A B C))

        ; 3
        (= (+ A B C) w)
        (= (+ A B D) w)
        (= (+ A C D) w)
        (= (+ B C D) w)
        
        (= (+ A B) (+ C w))
        (= (+ A B) (+ D w))
        (= (+ A C) (+ D w))
        (= (+ A C) (+ B w))
        (= (+ A D) (+ B w))
        (= (+ A D) (+ C w))
        (= (+ B C) (+ D w))
        (= (+ B C) (+ A w))
        (= (+ C D) (+ A w))
        (= (+ C D) (+ B w))
        
        (= A (+ B C w))
        (= A (+ B D w))
        (= A (+ C D w))
        (= B (+ A C w))
        (= B (+ A D w))
        (= B (+ C D w))
        (= C (+ A D w))
        (= C (+ A B w))
        (= C (+ B D w))
        
        ;2
        (= (+ A B) w)
        (= (+ A C) w)
        (= (+ A D) w)
        (= (+ B C) w)
        (= (+ B D) w)
        (= (+ C D) w)
        
        (= A (+ B w))
        (= A (+ C w))
        (= A (+ D w))
        (= B (+ A w))
        (= B (+ C w))
        (= B (+ D w))
        (= C (+ A w))
        (= C (+ B w))
        (= C (+ D w))
        (= D (+ A w))
        (= D (+ B w))
        (= D (+ C w))

        ; 1
        (= A w)
        (= B w)
        (= C w)
        (= D w)
      )
    )
  )
)

(check-sat)
(get-value (
  A B C D
))