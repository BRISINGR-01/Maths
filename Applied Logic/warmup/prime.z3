(declare-const p Int)
(declare-const q Int)

(assert (and (= 6 (* p q)) (distinct p 1 -1) (distinct q 1 -1)))

(check-sat)