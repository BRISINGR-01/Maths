q(declare-const A Int)
(declare-const S Int)
(declare-const I Int)
(declare-const W Int)
(declare-const T Int)
(declare-const H Int)
(declare-const M Int)
(declare-const O Int)
(declare-const E Int)

(assert (distinct 0 A))
(assert (distinct 0 I))
(assert (distinct 0 W))
(assert (distinct 0 M))

(assert (and (< 0 A) (> 10 A)))
(assert (and (<= 0 S) (> 10 S)))
(assert (and (< 0 I) (> 10 I)))
(assert (and (< 0 W) (> 10 W)))
(assert (and (<= 0 T) (> 10 T)))
(assert (and (<= 0 H) (> 10 H)))
(assert (and (< 0 M) (> 10 M)))
(assert (and (<= 0 O) (> 10 O)))
(assert (and (<= 0 E) (> 10 E)))

(assert (distinct A S I W T H M O E))

(assert (= 
  (+ 
    (+ S (* A 10)) I (+ S (* A 10) (* W 100)) (+ H (* T 10) (* I 100) (* W 1000))
  )
  (+ S (* E 10) (* S 100) (* O 1000) (* M 10000))
))
 
(check-sat)
(get-value (A S I W T H M O E))
