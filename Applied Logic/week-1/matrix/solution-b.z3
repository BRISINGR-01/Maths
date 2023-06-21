(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)


(assert (exists ((IA Int) (IB Int) (IC Int) (ID Int) (DI Int))
  (and
    (= DI (- (* A D) (* B C)))
    (distinct DI 0)
   
    (<= -9 IA 9)
    (<= -9 IB 9)
    (<= -9 IC 9)
    (<= -9 ID 9)
   
    (= IA (/ D DI))
    (= ID (/ A DI))
    (= IB (/ (* -1 B) DI))
    (= IC (/ (* -1 C) DI))
  )
))


(check-sat)
(get-value (A B C D))
