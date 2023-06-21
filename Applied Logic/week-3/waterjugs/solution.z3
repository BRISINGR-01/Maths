(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-fun S (Int Int) Int)

(define-fun NextS ((J Int) (r Int)) Int
  (S J (+ r 1))
)

(assert (= (S A 1) 8))
(assert (= (S B 1) 0))
(assert (= (S C 1) 0))
(assert (= (S A 8) 4))
(assert (= (S B 8) 4))
(assert (= (S C 8) 0))

(assert
  (forall ((r Int))
    (implies
      (<= 1 r 7)
      (and
        (= 8 (+ (S A r) (S B r) (S C r)))
        (<= 0 (S A r) 8)
        (<= 0 (S B r) 5)
        (<= 0 (S C r) 3)

        (ite (= (S A r) (NextS A r))
          (or
            (and
              (= (- (S B r) (- 3 (S C r))) (NextS B r))
              (= 3 (NextS C r))
            )
            (and
              (= 0 (NextS B r))
              (= (+ (S B r) (S C r)) (NextS C r))
            )
          )
          (ite (= (S C r) (NextS C r))
            (or
              (and
                (= (- (S A r) (- 5 (S B r))) (NextS A r))
                (= 5 (NextS B r))
              )
              (and
                (= 0 (NextS A r))
                (= (+ (S A r) (S B r)) (NextS B r))
              )
            )
            (and
              (= 0 (NextS C r))
              (= (+ (S A r) (S C r)) (NextS A r))
            )
          )
        )
      )
    )
  )
)



(check-sat)
(get-value (
  (S A 1)
  (S B 1)
  (S C 1)
  (S A 2)
  (S B 2)
  (S C 2)
  (S A 3)
  (S B 3)
  (S C 3)
  (S A 4)
  (S B 4)
  (S C 4)
  (S A 5)
  (S B 5)
  (S C 5)
  (S A 6)
  (S B 6)
  (S C 6)
  (S A 7)
  (S B 7)
  (S C 7)
  (S A 8)
  (S B 8)
  (S C 8)
))