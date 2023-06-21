(declare-const X Int)
(declare-fun hasLeft (Int) Bool)
(declare-fun S (Int) Int)

;(assert (= 1 (S 1)))

(assert 
  (forall ((r Int) (n Int))
    (implies
      (and
        ;(not (hasLeft n))
        ;(= 1 r)
        (< 0 r 2)
      )
    ;(ite (hasLeft 1)
      (implies
        (= n 1)
        ;(distinct 1 (mod (^ 2 r) n))
        (and
          (hasLeft n)
          (= (mod (^ 2 r) n) (S n))
        )
      )
    ;)
    )
  )
)

;(assert
;  (forall ((r Int))
;    (implies
;      (and
;        (> r 0)
;        (>= 1 (S r) 40)
;        (>= 1 (S r) 40)
;      )
;      (ite
;        (or
;          (exists ((n Int))
;            (and
;              (> (S r) n 41)
;              (not (hasLeft n))
;            )
;          )
;          (exists ((n Int))
;            (and
;              (> 0 n (S r))
;              (not (hasLeft n))
;            )
;          )
;        ) 
;        (= n (S (+ r 1)))
;        (= X (S r))
;      )
;      ;(implies
;      ;  (not
;      ;    (or
;      ;      (exists ((n Int))
;      ;        (and
;      ;          (> (S r) n 41)
;      ;          (not (hasLeft n))
;      ;          (= n (S (+ r 1)))
;      ;        )
;      ;      )
;      ;      (exists ((n Int))
;      ;        (and
;      ;          (> 0 n (S r))
;      ;          (not (hasLeft n))
;      ;          (= n (S (+ r 1)))
;      ;        )
;      ;      )
;      ;    ) 
;      ;  )
;      ;  (= X (S r))
;      ;)
;    )
;  )
;)

(check-sat)
(get-value (
  X
  (hasLeft 1)
  (hasLeft 2)
  (hasLeft 3)
  (hasLeft 4)
  (hasLeft 5)
  (hasLeft 6)
  (hasLeft 7)
  (hasLeft 8)
  (S 1)
  (S 2)
  (S 3)
  (S 4)
))

; (2^r) * n - (2^(r - 1) - 1)
; (x + 2^r - 1) % (2^4)
; 2 * n
; 4 * n - 1
; 8 * n - 3
; 16 * n - 7
; 32 * n - 15
; 64 * n - 31

; n > 0
; 2 * n - 1
; 4 * n - 3
; 8 * n - 7

;1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
;1   3   5   7   9    11    13    15    17    19    21    23    25    27    29    31    33    35    37    39    1
;1       5       9          13          17          21          25          29          33          37          1     
;1               9                      17                      25                      33                      1   
;1                                      17                                              33                      
;                                       17                                                                

;1 2 3 4 5 6 7 8 9 10 11
;1   3   5   7   9    11
;    3       7        11
;            7    
;                       