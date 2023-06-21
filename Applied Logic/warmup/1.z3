(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)
(declare-const N Int)

(assert (= A true))
(assert (= B true))
(assert (= C false))
(assert (= D true))
(assert (= N (+ (ite A 1 0) (ite B 1 0) (ite C 1 0) (ite D 1 0))))

(check-sat)
(get-value (N))