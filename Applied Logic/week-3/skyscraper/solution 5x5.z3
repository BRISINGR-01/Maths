(declare-const A1 Int)
(declare-const B1 Int)
(declare-const C1 Int)
(declare-const D1 Int)
(declare-const E1 Int)
(declare-const A2 Int)
(declare-const B2 Int)
(declare-const C2 Int)
(declare-const D2 Int)
(declare-const E2 Int)
(declare-const A3 Int)
(declare-const B3 Int)
(declare-const C3 Int)
(declare-const D3 Int)
(declare-const E3 Int)
(declare-const A4 Int)
(declare-const B4 Int)
(declare-const C4 Int)
(declare-const D4 Int)
(declare-const E4 Int)
(declare-const A5 Int)
(declare-const B5 Int)
(declare-const C5 Int)
(declare-const D5 Int)
(declare-const E5 Int)

(assert (distinct A1 B1 C1 D1 E1))
(assert (distinct A2 B2 C2 D2 E2))
(assert (distinct A3 B3 C3 D3 E3))
(assert (distinct A4 B4 C4 D4 E4))
(assert (distinct A5 B5 C5 D5 E5))


(assert (distinct A1 A2 A3 A4 A5))
(assert (distinct B1 B2 B3 B4 B5))
(assert (distinct C1 C2 C3 C4 C5))
(assert (distinct D1 D2 D3 D4 D5))
(assert (distinct E1 E2 E3 E4 E5))


(assert (<= 1 A1 5))
(assert (<= 1 B1 5))
(assert (<= 1 C1 5))
(assert (<= 1 D1 5))
(assert (<= 1 E1 5))
(assert (<= 1 A2 5))
(assert (<= 1 B2 5))
(assert (<= 1 C2 5))
(assert (<= 1 D2 5))
(assert (<= 1 E2 5))
(assert (<= 1 A3 5))
(assert (<= 1 B3 5))
(assert (<= 1 C3 5))
(assert (<= 1 D3 5))
(assert (<= 1 E3 5))
(assert (<= 1 A4 5))
(assert (<= 1 B4 5))
(assert (<= 1 C4 5))
(assert (<= 1 D4 5))
(assert (<= 1 E4 5))
(assert (<= 1 A5 5))
(assert (<= 1 B5 5))
(assert (<= 1 C5 5))
(assert (<= 1 D5 5))
(assert (<= 1 E5 5))


(define-fun max ((x Int) (y Int)) Int
  (ite (< x y) y x))

(define-fun solveLine ((N Int) (A Int) (B Int) (C Int) (D Int) (E Int)) Bool
  (= (- N 1) (+ (ite (< A B) 1 0) (ite (< (max A B) C) 1 0) (ite (< (max (max A B) C) D) 1 0) (ite (< (max (max (max A B) C) D) E) 1 0)))
)

;; left
(assert (solveLine 2 A1 B1 C1 D1 E1))
(assert (solveLine 2 A2 B2 C2 D2 E2))
(assert (solveLine 1 A3 B3 C3 D3 E3))
(assert (solveLine 3 A4 B4 C4 D4 E4))
(assert (solveLine 4 A5 B5 C5 D5 E5))

;; right
(assert (solveLine 2 E1 D1 C1 B1 A1))
(assert (solveLine 4 E2 D2 C2 B2 A2))
(assert (solveLine 3 E3 D3 C3 B3 A3))
(assert (solveLine 2 E4 D4 C4 B4 A4))
(assert (solveLine 1 E5 D5 C5 B5 A5))

;; top
(assert (solveLine 2 A1 A2 A3 A4 A5))
(assert (solveLine 2 B1 B2 B3 B4 B5))
(assert (solveLine 3 C1 C2 C3 C4 C5))
(assert (solveLine 1 D1 D2 D3 D4 D5))
(assert (solveLine 4 E1 E2 E3 E4 E5))

;; bottom
(assert (solveLine 2 A5 A4 A3 A2 A1))
(assert (solveLine 4 B5 B4 B3 B2 B1))
(assert (solveLine 2 C5 C4 C3 C2 C1))
(assert (solveLine 2 D5 D4 D3 D2 D1))
(assert (solveLine 1 E5 E4 E3 E2 E1))


(check-sat)
(get-value (A1 B1 C1 D1 E1 A2 B2 C2 D2 E2 A3 B3 C3 D3 E3 A4 B4 C4 D4 E4 A5 B5 C5 D5 E5))

