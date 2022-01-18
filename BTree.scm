(define tree '("R" 100 999 
                   (
                    ("R" 100 199
                         (
                            ("L" 120 140 160 180)
                         )
                    )
                    ("R" 200 299
                        (
                           ("L" 220 240 260 280)
                        )
                    )
                    )
                   )
  )

(define (searchleaflist leafnode value) ;NEEDS TO BE CALLED ON (listwithin AnyGivenLeafNode), NOT AnyGivenLeafNode
  (if (not (null? leafnode))
      (if (= (car leafnode) value)
          #t
          (searchleaflist (cdr leafnode) value)
      )
      #f
   )
)

(define (maxvalue rootnode)
  (car (cdr (cdr rootnode)))
)

(define (minvalue rootnode)
  (car (cdr rootnode))
)

(define (listwithin node) ;Function is polymorphic only for the sake of legibility
  (if (equal? "L" (car node))
      (cdr node) ;list starts at 2nd item for leaf 
      (car (cdr (cdr (cdr node)))) ;list IS 4th item of root
  )
)

(define (fitsinrange tree value)
  (or (> value (maxvalue tree)) (< value (minvalue tree)))
)

(define (search tree value)
  (if (fitsinrange tree value)
      #f
      (searchrootlist (listwithin tree) value)
  )
)

(define (searchrootlist rootlist value)
  (cond
    ((if (null? rootlist) 
         #t
         #f
     ) #f)
    ((if (equal? "L" (car (car rootlist)))
         (searchleaflist (listwithin (car rootlist)) value)
         (search (car rootlist) value)
     ) #t)
    ((searchrootlist (cdr rootlist) value) #t)
    (#t #f) ; else: value not found
  )
)
         
  

