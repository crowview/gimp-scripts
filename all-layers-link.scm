(script-fu-register "script-fu-all-layers-link"
  "<Image>/Layer/All Layers/Link All"
  "Link's em up"
  "JM"
  "JM"
  "November 12, 2016"
  "*"
  SF-IMAGE      "Image" 0
  SF-DRAWABLE   "Drawable" 0
  SF-OPTION     "What to do???" '("Unlink all" "Link all" "Switch mode for all") 
)

(define (script-fu-all-layers-link img drawable option)

  (gimp-context-push)
  (gimp-image-undo-group-start img)
  
  (cond ((= option 2)
         (map (lambda (x) (gimp-item-set-linked x (cond ((= (car(gimp-item-get-linked x)) 1) 0)
                                                        ('t 1))))
              (vector->list (cadr (gimp-image-get-layers img)))))
         ('t (map (lambda (x) (gimp-item-set-linked x option))
             (vector->list (cadr (gimp-image-get-layers img))))))
 
  (gimp-image-undo-group-end img)
  (gimp-context-pop)
  (gimp-displays-flush)
)


