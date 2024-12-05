(define (domain examplemove)
  (:requirements :strips :typing) 
  (:types room robot)

  (:predicates 
		(at ?r - robot ?l - room)
		(clear ?l - room)
)

(:action move
	     :parameters (?r - robot ?l1 - room ?l2 - room)
	     :precondition (and (at ?r ?l1) (clear ?l2))
	     :effect
	     (and (clear ?l1)
		   (at ?r ?l2)))
)
