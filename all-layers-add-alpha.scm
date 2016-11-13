;; I didn't write this one, but I referenced it when I made a couple of my own scripts.
;; Wouldn't have known about pushing context or undo groups without it.
;; Uploading for posterity - JM


; GIMP - The GNU Image Manipulation Program
; Copyright (C) 1995 Spencer Kimball and Peter Mattis
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;
;
;
;
; Script can be found under Layer > All Layers > Add Alpha to All Layers


; Define the Function

(define (script-fu-all-layers-add-alpha img drawable)


  (gimp-context-push)
  (gimp-image-undo-group-start img)

  (map (lambda (x) (gimp-layer-add-alpha x)) (vector->list (cadr (gimp-image-get-layers img))))

  (gimp-image-undo-group-end img)
  (gimp-context-pop)
  (gimp-displays-flush)
)

(script-fu-register "script-fu-all-layers-add-alpha"
  "<Image>/Layer/All Layers/Add Alpha to All Layers"
  "Adds an alpha channel to all layers in the image.\n\n[all-layers-add-alpha.scm]"
  "Brian Hahn"
  "Brian Hahn"
  "May 2011"
  "*"
  SF-IMAGE          "Image" 0
  SF-DRAWABLE       "Drawable" 0
)
