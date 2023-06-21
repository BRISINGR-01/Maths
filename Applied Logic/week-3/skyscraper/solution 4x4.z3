(declare-const A1 Int)
(declare-const B1 Int)
(declare-const C1 Int)
(declare-const D1 Int)
(declare-const A2 Int)
(declare-const B2 Int)
(declare-const C2 Int)
(declare-const D2 Int)
(declare-const A3 Int)
(declare-const B3 Int)
(declare-const C3 Int)
(declare-const D3 Int)
(declare-const A4 Int)
(declare-const B4 Int)
(declare-const C4 Int)
(declare-const D4 Int)

(assert (distinct A1 B1 C1 D1))
(assert (distinct A2 B2 C2 D2))
(assert (distinct A3 B3 C3 D3))
(assert (distinct A4 B4 C4 D4))


(assert (distinct A1 A2 A3 A4))
(assert (distinct B1 B2 B3 B4))
(assert (distinct C1 C2 C3 C4))
(assert (distinct D1 D2 D3 D4))


(assert (<= 1 A1 4))
(assert (<= 1 B1 4))
(assert (<= 1 C1 4))
(assert (<= 1 D1 4))
(assert (<= 1 A2 4))
(assert (<= 1 B2 4))
(assert (<= 1 C2 4))
(assert (<= 1 D2 4))
(assert (<= 1 A3 4))
(assert (<= 1 B3 4))
(assert (<= 1 C3 4))
(assert (<= 1 D3 4))
(assert (<= 1 A4 4))
(assert (<= 1 B4 4))
(assert (<= 1 C4 4))
(assert (<= 1 D4 4))


(define-fun max ((x Int) (y Int)) Int
  (ite (< x y) y x)
)

(define-fun solveLine ((N Int) (A Int) (B Int) (C Int) (D Int)) Bool
  (= (- N 1) (+ (ite (< A B) 1 0) (ite (< (max A B) C) 1 0) (ite (< (max (max A B) C) D) 1 0)))
)

;; left
(assert (solveLine 2 A1 B1 C1 D1))
(assert (solveLine 3 A2 B2 C2 D2))
(assert (solveLine 2 A3 B3 C3 D3))
(assert (solveLine 1 A4 B4 C4 D4))

;; right
(assert (solveLine 2 D1 C1 B1 A1))
(assert (solveLine 1 D2 C2 B2 A2))
(assert (solveLine 2 D3 C3 B3 A3))
(assert (solveLine 3 D4 C4 B4 A4))

;; top
(assert (solveLine 4 A1 A2 A3 A4))
(assert (solveLine 1 B1 B2 B3 B4))
(assert (solveLine 3 C1 C2 C3 C4))
(assert (solveLine 2 D1 D2 D3 D4))

;; bottom
(assert (solveLine 1 A4 A3 A2 A1))
(assert (solveLine 2 B4 B3 B2 B1))
(assert (solveLine 2 C4 C3 C2 C1))
(assert (solveLine 2 D4 D3 D2 D1))


(check-sat)
(get-value (A1 B1 C1 D1 A2 B2 C2 D2 A3 B3 C3 D3 A4 B4 C4 D4))

