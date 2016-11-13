(script-fu-register
    "script-fu-all-layers-dissolve-edge"
    "<Image>/Layer/All Layers/Dissolve Edge (except bottom layer)"
    "Creates transparent gradient of N pixels on the edge of your choice in all layers"
    "JM"
    "JM 2016"
    "November 12, 2016"
    "*"
            
    SF-IMAGE        "Image" 0
    SF-DRAWABLE     "Drawable" 0
    SF-OPTION       "Edge" '("Bottom" "Top" "Left" "Right") 
    SF-ADJUSTMENT   "Size" '(20 0 100 1 10 1 0)
) 

;; 1. Create a loop through all layers except last
;; 2. On each layer,
;;  2.25 Check if it's linked
;;  2.5 Get the dimensions of the layer
;;  3. Create a layer mask
;;  4. Blend the specified side using specified percentage
;;  5. Apply the mask
;; 6. Pop context

(define (script-fu-all-layers-dissolve-edge img drawable edge size)
    (let ((x-one (cond ((= edge 3) 1) 
                       ('t 0)))
          (y-one (cond ((= edge 0) 1) 
                       ('t 0)))
          (x-two (cond ((= edge 2) (/ size 100)) 
                       ((= edge 3) (- 1 (/ size 100))) 
                       ('t 0)))
          (y-two (cond ((= edge 0) (- 1 (/ size 100)))
                       ((= edge 1) (/ size 100))
                       ('t 0))))
          
     (define (process-layer layers)
         (cond ((or (null? layers) (null? (cdr layers))) 'exit-loop)
               ('otherwise
                (gimp-layer-add-mask (car layers)
                                     (car (gimp-layer-create-mask (car layers)
                                                                  0)))
                (gimp-edit-blend (car (gimp-layer-get-mask (car layers))) ; might be able to re-use mask, assuming all layers are same dimensions
                                 0 0 0 100 0 0 0 0 1 0 1  ; see documentation
                                 (* x-one (car (gimp-drawable-width (car layers))))  ;x1
                                 (* y-one (car (gimp-drawable-height (car layers)))) ;y1
                                 (* x-two (car (gimp-drawable-width (car layers))))  ;x2
                                 (* y-two (car (gimp-drawable-height (car layers))))) ;y2
                (gimp-layer-remove-mask (car layers) 0)
                
                (process-layer (cdr layers))
               )))
                
     (gimp-context-push)
     (gimp-context-set-foreground "black")
     (gimp-context-set-background "white")
     (gimp-image-undo-group-start img)
    
     (process-layer (vector->list (cadr (gimp-image-get-layers img))))

     (gimp-image-undo-group-end img)
     (gimp-context-pop)
     (gimp-displays-flush)
    )
)