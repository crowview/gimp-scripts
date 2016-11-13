(script-fu-register "script-fu-all-layers-make-visible"
  "<Image>/Layer/All Layers/Make All Visible"
  "make bisible's em up"
  "JM"
  "JM"
  "November 12, 2016"
  "*"
  SF-IMAGE      "Image" 0
  SF-DRAWABLE   "Drawable" 0
  SF-OPTION     "What to do???" '("Make all invisible" "Make all visible" "Toggle all") 
)

(define (script-fu-all-layers-make-visible img drawable option)

  (gimp-context-push)
  (gimp-image-undo-group-start img)
  
  (cond ((= option 2)
         (map (lambda (x) (gimp-item-set-visible x (cond ((= (car(gimp-item-get-visible x)) 1) 0)
                                                        ('t 1))))
              (vector->list (cadr (gimp-image-get-layers img)))))
         ('t (map (lambda (x) (gimp-item-set-visible x option))
             (vector->list (cadr (gimp-image-get-layers img))))))
 
  (gimp-image-undo-group-end img)
  (gimp-context-pop)
  (gimp-displays-flush)
)


