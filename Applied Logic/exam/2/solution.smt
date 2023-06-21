(declare-fun E (Int Int) Bool)
;            vertex verex -> is there an edge in between

(define-fun isEdge ((vec1 Int) (vec2 Int)) Bool
  ; because the graph is not directed we need to account for either an edge from A to B or from B to A - they have to be interreplacable
  (or
    (E vec1 vec2)
    (E vec2 vec1)
  )
)

(assert 
  (forall ((vec1 Int) (vec2 Int) (vec3 Int))
    (implies
      (and
        (<= 1 vec1 5)
        (<= 1 vec2 5)
        (<= 1 vec3 5)
        ; the graph has 5 vertices
        (distinct vec1 vec2 vec3)
        ; there cannot be an edge with 2 identical ends and in the problem is stated they have to be different
      )
      (and
        (or
          (not (isEdge vec1 vec2))
          (not (isEdge vec1 vec3))
          (not (isEdge vec2 vec3))
        )
        (or
          (isEdge vec1 vec2)
          (isEdge vec1 vec3)
          (isEdge vec2 vec3)
        )
      )
    )
  )
)

(check-sat)
(get-value (
  (E 1 2) (E 1 3) (E 1 4) (E 1 5)
  (E 2 1) (E 2 3) (E 2 4) (E 2 5)
  (E 3 1) (E 3 2) (E 3 4) (E 3 5)
  (E 4 1) (E 4 2) (E 4 3) (E 4 5)
  (E 5 1) (E 5 2) (E 5 3) (E 5 4)
))