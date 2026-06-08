;;; Sample layer utility command.

(defun c:CPTMAKELAYER (/ layer-name color-number)
  (setq layer-name (getstring T "\nLayer name: "))
  (setq color-number (getint "\nColor number <7>: "))
  (if (not color-number)
    (setq color-number 7)
  )
  (if (> (strlen layer-name) 0)
    (progn
      (command "_.-LAYER" "_M" layer-name "_C" color-number layer-name "")
      (princ (strcat "\nLayer ready: " layer-name))
    )
    (princ "\nNo layer name entered.")
  )
  (princ)
)
