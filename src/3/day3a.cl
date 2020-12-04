(defn advance 
    [lastpos slope]
(
    if-let [line (last (repeatedly (get slope :y) read-line))]
    (let [
        newx (mod (+ (get slope :x) (get lastpos :x)) (count line))
        ]
        
        (advance {
            :x newx
            :trees (
                if (= "#" (str (nth line newx)))
                (+ 1 (get lastpos :trees))
                (get lastpos :trees)
            ) 
        } slope)
    )
    lastpos
))

(
  println 
    (get (let [
        line (read-line)
        state {:x 0 :trees 0}
        slope {:x 1 :y 2}
    ] (
        advance state slope
    )) :trees)
)