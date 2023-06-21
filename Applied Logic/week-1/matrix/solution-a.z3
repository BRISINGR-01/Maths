(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const IA Int)
(declare-const IB Int)
(declare-const IC Int)
(declare-const ID Int)

(assert (= A 3))
(assert (= B 1))
(assert (= C 5))
(assert (= D 2))

(declare-const DI Int)

(assert (= DI (- (* A D) (* B C))))
(assert (distinct DI 0))

(assert ( and 
  (= IA (/ D DI))
  (= ID (/ A DI))
  (= IB (/ (* -1 B) DI))
  (= IC (/ (* -1 C) DI))
))

(check-sat)
(get-value (IA IB IC ID))
