(declare-const A Int)
(declare-const B Int)
(declare-fun Step (Int Int) Int)

(assert 
  (forall ((r Int))
    (implies
      (<= 1 r 10)
      (ite
        (> (Step A r) (Step B r))
          (and
            (= 
              (Step B (+ 1 r))
              (* 2 (Step B r))
            )
            (= 
              (Step A (+ 1 r))
              (- (Step A r) 3)
            )
          )
          (and
            (= 
              (Step A (+ 1 r))
              (* 2 (Step A r))
            )
            (= 
              (Step B (+ 1 r))
              (- (Step B r) 5)
            )
          )
      )
    )
  )
)

(assert 
  (and
    (= 1000 (Step A 10))
    (= 999 (Step B 10))
  )
)

(check-sat)
(get-value (
  (Step A 1)
  (Step B 1)
))