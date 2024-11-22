(define (domain examplemove)
  (:requirements :strips :typing) 
  (:types room robot)

  (:predicates 
		(at ?r - robot ?l - room)
)

(:action move
	     :parameters (?r - robot ?l1 - room ?l2 - room)
	     :precondition (and(at ?r - robot ?l1 - room)(not(at ?r - robot ?l2 - room)))
	     :effect
	     (and (not ((at ?r - robot ?l1 - room)))
		   (at ?r - robot ?l2 - room))
)
