(define (problem EXAMPLE-1)
	(:domain examplemove)
	(:objects
	r - robot
	l1 - room
	l2 - room
	)
	(:init
	(at r l1)
)
	(:goal (and
	(at r l2)
	))
)
