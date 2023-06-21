(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-fun F (Int Int) Int)
;              dice side val

(assert 
  (forall ((side Int))
    (implies (<= 1 side 6)
      (and
        (<= 0 (F A side))
        (<= 0 (F B side))
        (<= 0 (F C side))
        (<= 0 (F D side))
      )
    )
  )
)

(define-fun Compare ((D1 Int) (D2 Int)) Bool
  (<
    3
    (+
      (ite (> (F D1 1) (F D2 1)) 1 0)
      (ite (> (F D1 2) (F D2 2)) 1 0)
      (ite (> (F D1 3) (F D2 3)) 1 0)
      (ite (> (F D1 4) (F D2 4)) 1 0)
      (ite (> (F D1 5) (F D2 5)) 1 0)
      (ite (> (F D1 6) (F D2 6)) 1 0)
    )
  )
)

(assert (Compare A B))
(assert (Compare B C))
(assert (Compare C D))
(assert (Compare D A))

(check-sat)
(get-value (
  (F A 1) (F B 1) (F C 1) (F D 1)
  (F A 2) (F B 2) (F C 2) (F D 2)
  (F A 3) (F B 3) (F C 3) (F D 3)
  (F A 4) (F B 4) (F C 4) (F D 4)
  (F A 5) (F B 5) (F C 5) (F D 5)
  (F A 6) (F B 6) (F C 6) (F D 6)
))