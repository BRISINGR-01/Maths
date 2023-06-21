(declare-const A Int)

(assert
  (exists ((p Int))
    (and
      (<= 1 p 10)
      (<= 80 (* p p))
    )
  )
)

(assert
  (and
    (<= 1 A 10)
    (<= 80 (* A A))
  )
)


(check-sat)