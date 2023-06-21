(declare-const N1 Int)
(declare-const N2 Int)
(declare-const N3 Int)
(declare-const N4 Int)
(declare-const N5 Int)

(assert (and
  (<= 1 N1 5)
  (<= 1 N2 5)
  (<= 1 N3 5)
  (<= 1 N4 5)
  (<= 1 N5 5)
  (distinct N1 N2 N3 N4 N5)
))

(define-fun check-rotated ((r1 Int) (r2 Int) (r3 Int) (r4 Int) (r5 Int)) Bool
  (<= 1 (+
    (ite (= 1 r1) 1 0)
    (ite (= 2 r2) 1 0)
    (ite (= 3 r3) 1 0)
    (ite (= 4 r4) 1 0)
    (ite (= 5 r5) 1 0)
  ))
)

(assert (and
  (check-rotated N1 N2 N3 N4 N5)
  (check-rotated N2 N3 N4 N5 N1)
  (check-rotated N3 N4 N5 N1 N2)
  (check-rotated N4 N5 N1 N2 N3)
  (check-rotated N5 N1 N2 N3 N4)
))

(check-sat)
(get-value (N1 N2 N3 N4 N5))