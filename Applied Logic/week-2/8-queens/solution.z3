(declare-fun QR (Int) Int)
(declare-fun QC (Int) Int)

(assert 
  (forall ((n1 Int) (n2 Int))
    (implies
      (and
        (distinct n1 n2)
        (<= 1 n1 8)
        (<= 1 n2 8)
      )
      (and
        (<= 1 (QC n1) 8)
        (<= 1 (QC n2) 8)
        (<= 1 (QR n1) 8)
        (<= 1 (QR n2) 8)
        (distinct (QR n1) (QR n2))
        (distinct (QC n1) (QC n2))
        ; top to bottom diagonal
        (distinct 
          (- (QC n1) (QC n2))
          (- (QR n1) (QR n2))
        )
        ; bottom to top diagonal
        (distinct 
          (+ (QR n1) (QC n1))
          (+ (QR n2) (QC n2))
        )
      )
    )
  )
)


(check-sat)
(get-value (
  (QR 1) (QC 1)
  (QR 2) (QC 2)
  (QR 3) (QC 3)
  (QR 4) (QC 4)
  (QR 5) (QC 5)
  (QR 6) (QC 6)
  (QR 7) (QC 7)
  (QR 8) (QC 8)
))