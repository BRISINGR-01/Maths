(declare-fun M (Int Int) Bool)
;         (medicine round) -> has been tested


(assert
  (and
    (forall ((r Int))
      (implies
        (<= 1 r 10)
        (= 3
          (+
            (ite (M 1 r) 1 0)
            (ite (M 2 r) 1 0)
            (ite (M 3 r) 1 0)
            (ite (M 4 r) 1 0)
            (ite (M 5 r) 1 0)
            (ite (M 6 r) 1 0)
          )
        )
      )
    )
    (forall ((n Int))
      (implies
        (<= 1 n 6)
        (= 5
          (+
            (ite (M n 1) 1 0)
            (ite (M n 2) 1 0)
            (ite (M n 3) 1 0)
            (ite (M n 4) 1 0)
            (ite (M n 5) 1 0)
            (ite (M n 6) 1 0)
            (ite (M n 7) 1 0)
            (ite (M n 8) 1 0)
            (ite (M n 9) 1 0)
            (ite (M n 10) 1 0)
          )
        )
      )
    )
    (forall ((n1 Int) (n2 Int))
      (implies
        (and
          (<= 1 n1 6)
          (<= 1 n2 6)
          (distinct n1 n2)
        )
        (=  
          2
          (+
            (ite (and (M n1 1) (M n2 1)) 1 0)
            (ite (and (M n1 2) (M n2 2)) 1 0)
            (ite (and (M n1 3) (M n2 3)) 1 0)
            (ite (and (M n1 4) (M n2 4)) 1 0)
            (ite (and (M n1 5) (M n2 5)) 1 0)
            (ite (and (M n1 6) (M n2 6)) 1 0)
            (ite (and (M n1 7) (M n2 7)) 1 0)
            (ite (and (M n1 8) (M n2 8)) 1 0)
            (ite (and (M n1 9) (M n2 9)) 1 0)
            (ite (and (M n1 10) (M n2 10)) 1 0)
          )
        )
      )
    )
  )
)

(check-sat)
(get-value (
  (M 1 1)  (M 2 1)  (M 3 1)  (M 4 1)  (M 5 1)  (M 6 1) 
  (M 1 2)  (M 2 2)  (M 3 2)  (M 4 2)  (M 5 2)  (M 6 2) 
  (M 1 3)  (M 2 3)  (M 3 3)  (M 4 3)  (M 5 3)  (M 6 3) 
  (M 1 4)  (M 2 4)  (M 3 4)  (M 4 4)  (M 5 4)  (M 6 4) 
  (M 1 5)  (M 2 5)  (M 3 5)  (M 4 5)  (M 5 5)  (M 6 5) 
  (M 1 6)  (M 2 6)  (M 3 6)  (M 4 6)  (M 5 6)  (M 6 6) 
  (M 1 7)  (M 2 7)  (M 3 7)  (M 4 7)  (M 5 7)  (M 6 7) 
  (M 1 8)  (M 2 8)  (M 3 8)  (M 4 8)  (M 5 8)  (M 6 8) 
  (M 1 9)  (M 2 9)  (M 3 9)  (M 4 9)  (M 5 9)  (M 6 9) 
  (M 1 10) (M 2 10) (M 3 10) (M 4 10) (M 5 10) (M 6 10)
))