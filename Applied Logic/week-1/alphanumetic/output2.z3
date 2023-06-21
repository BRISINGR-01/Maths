(declare-const C Int)
(declare-const O Int)
(declare-const R Int)
(declare-const A Int)
(declare-const L Int)
(declare-const Y Int)
(declare-const N Int)
(declare-const M Int)
(declare-const V Int)
(declare-const S Int)

(assert (distinct 0 C))
(assert (distinct 0 M))
(assert (distinct 0 N))
(assert (distinct 0 S))

(assert (and (< 0 C) (> 10 C)))
(assert (and (<= 0 O) (> 10 O)))
(assert (and (<= 0 R) (> 10 R)))
(assert (and (<= 0 A) (> 10 A)))
(assert (and (<= 0 L) (> 10 L)))
(assert (and (<= 0 Y) (> 10 Y)))
(assert (and (< 0 N) (> 10 N)))
(assert (and (< 0 M) (> 10 M)))
(assert (and (<= 0 V) (> 10 V)))
(assert (and (< 0 S) (> 10 S)))

(assert (distinct C O R A L Y N M V S))

(assert (= 
  (+ 
    (+ L (* A 10) (* R 100) (* O 1000) (* C 10000)) (+ N (* A 10) (* Y 100) (* C 1000)) (+ N (* O 10) (* O 100) (* R 1000) (* A 10000) (* M 100000)) (+ Y (* V 10) (* A 100) (* N 1000)) (+ N (* O 10) (* M 100) (* L 1000) (* A 10000) (* S 100000))
  )
  (+ S (* R 10) (* O 100) (* L 1000) (* O 10000) (* C 100000))
))
 
(check-sat)
(get-value (C O R A L Y N M V S))
