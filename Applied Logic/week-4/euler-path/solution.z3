(declare-fun E (Int Int) Int)
(declare-const V1 Int)
(declare-const V2 Int)
(declare-const V3 Int)
(declare-const V4 Int)
(declare-const V5 Int)
(declare-const V6 Int)
(declare-fun SFrom (Int) Int)
(declare-fun STo (Int) Int)
;             vertex round

(assert (distinct V1 V2 V3 V4 V5 V6))

;(assert
;  (forall ((v1 Int) (v2 Int))
;    (implies
;      (and
;        (<= 1 v1 6)
;        (<= 1 v2 6)
;      )
;      (ite (< 0 (E v2 v1))
;        (= (E v2 v1) (E v1 v2))
;        (= 0 (E v1 v2))
;      )
;    )
;  )
;)

;(define-fun CanPass ((v1 Int) (v2 Int)) Bool
;  (and
;    (distinct v1 v2)
;    (ite
;      ;if the path from v1 to v2 is traversed
;      (or
;        (= (+ (S v1) 1) (S v2))
;        (= (+ (S v2) 1) (S v1))
;      )
;      (or
;        (= 2 (E v2 v1))
;        (= 2 (E v1 v2))
;      )
;      ; otherwise check if there is a path at all
;      (or
;        (< 0 (E v1 v2))
;        (< 0 (E v2 v1))
;      )
;    )
;  )
;)


;(assert
;  (forall ((r Int))
;    (implies
;      (and
;        (<= 2 r 13)
;      )
;      (ite (CanPass V1 (S (- r 1)))
;        (= V1 (S r))
;        (ite (CanPass V2 (S (- r 1)))
;          (= V2 (S r))
;          (ite (CanPass V3 (S (- r 1)))
;            (= V3 (S r))
;            (ite(CanPass V4 (S (- r 1)))
;              (= V4 (S r))
;              (ite(CanPass V5 (S (- r 1)))
;                (= V5 (S r))
;                (ite (CanPass V6 (S (- r 1)))
;                  (= V6 (S r))
;                  (ite (CanPass V7 (S (- r 1)))
;                    (= V7 (S r))
;                    false
;                  )
;                )
;              )
;            )
;          )
;        )
;      )
;    )
;  )
;)

;(assert 
;  (forall ((vec1 Int) (vec2 Int))
;    (implies
;      (and
;        (<= 1 vec1 6)
;        (<= 1 vec2 6)
;        (distinct vec1 vec2)
;      )
;      (and
;        (<= 1 (SFrom vec1) 13)
;        (<= 1 (STo vec2) 13)
;        (= (SFrom vec1) (STo vec2))
;        (implies 
;          (distinct 1 (SFrom vec1)) 
;          (= (- (SFrom vec1) 1) (STo vec1))
;        )
;        ;(implies 
;        ;  (distinct 13 (STo vec2)) 
;        ;  (= (+ (STo vec2) 1) (SFrom vec2))
;        ;)
;      )
;    )
;  )
;)

;(assert (forall ((r Int))
;  (implies
;    (and
;      (<= 1 r 13)
;    )
;    (and
;      (or
;        (= (SFrom r) V1)
;        (= (SFrom r) V2)
;        (= (SFrom r) V3)
;        (= (SFrom r) V4)
;        (= (SFrom r) V5)
;        (= (SFrom r) V6)
;      )
;      (distinct (SFrom r) (STo r))
;      (=
;        (SFrom r)
;        (STo (- r 1))
;      )
;      (implies
;        (= (SFrom r) V1)
;        (or
;          (= (STo r) V2)
;          (= (STo r) V3)
;          (= (STo r) V4)
;        )
;      )
;      (implies
;        (= (SFrom r) V2)
;        (or
;          (= (STo r) V1)
;          (= (STo r) V3)
;          (= (STo r) V5)
;        )
;      )
;      (implies
;        (= (SFrom r) V3)
;        (or
;          (= (STo r) V1)
;          (= (STo r) V2)
;          (= (STo r) V4)
;          (= (STo r) V5)
;          (= (STo r) V6)
;        )
;      )
;      (implies
;        (= (SFrom r) V4)
;        (or
;          (= (STo r) V1)
;          (= (STo r) V3)
;          (= (STo r) V6)
;        )
;      )
;      (implies
;        (= (SFrom r) V5)
;        (or
;          (= (STo r) V2)
;          (= (STo r) V3)
;          (= (STo r) V6)
;        )
;      )
;      (implies
;        (= (SFrom r) V6)
;        (or
;          (= (STo r) V4)
;          (= (STo r) V3)
;          (= (STo r) V5)
;        )
;      )
;    )
;  )
;))

(assert (forall ((r Int))
  (implies (<= 1 r 13)
    (and
      (<= 1 (SFrom r) 6)
      (<= 1 (STo r) 6)
      (distinct (SFrom r) (STo r))
      (= (SFrom r) (STo (+ r 1)))
    )
  )
))

(define-fun edge ((vec1 Int) (vec2 Int) (r Int)) Int
  (ite 
    (and
      (= vec1 (SFrom r))
      (= vec2 (STo r))
    )
  1 0)
)

(define-fun edgeExists ((vec1 Int) (vec2 Int) (n Int)) Bool
  (= n
    (+
      (edge vec1 vec2 1)
      (edge vec2 vec1 1)
      (edge vec1 vec2 2)
      (edge vec2 vec1 2)
      (edge vec1 vec2 3)
      (edge vec2 vec1 3)
      (edge vec1 vec2 4)
      (edge vec2 vec1 4)
      (edge vec1 vec2 5)
      (edge vec2 vec1 6)
      (edge vec1 vec2 6)
      (edge vec2 vec1 7)
      (edge vec1 vec2 7)
      (edge vec2 vec1 8)
      (edge vec1 vec2 8)
      (edge vec2 vec1 9)
      (edge vec1 vec2 9)
      (edge vec2 vec1 10)
      (edge vec1 vec2 10)
      (edge vec2 vec1 11)
      (edge vec1 vec2 11)
      (edge vec2 vec1 12)
      (edge vec1 vec2 12)
      (edge vec2 vec1 13)
      (edge vec1 vec2 13)
    )
  )
)

(assert (edgeExists 1 2 1))
(assert (edgeExists 1 3 1))
(assert (edgeExists 2 5 1))

(assert (edgeExists 4 1 1))
(assert (edgeExists 4 2 1))
(assert (edgeExists 4 3 1))
(assert (edgeExists 4 5 1))

(assert (edgeExists 6 3 2))
(assert (edgeExists 6 4 2))
(assert (edgeExists 6 5 2))

(check-sat)
(get-value (
  (SFrom 1)
  (STo 1)
  (SFrom 2)
  (STo 2)
  (SFrom 3)
  (STo 3)
  (SFrom 4)
  (STo 4)
  (SFrom 5)
  (STo 5)
  (SFrom 6)
  (STo 6)
  (SFrom 7)
  (STo 7)
  (SFrom 8)
  (STo 8)
  (SFrom 9)
  (STo 9)
  (SFrom 10)
  (STo 10)
  (SFrom 11)
  (STo 11)
  (SFrom 12)
  (STo 12)
  (SFrom 13)
  (STo 13)
))