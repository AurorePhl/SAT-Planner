(define (problem depotprob5646) (:domain Depot)
(:objects
	depot0 depot1 depot2 - Depot
	distributor0 distributor1 distributor2 - Distributor
	truck0 truck1 truck2 truck3 truck4 truck5 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate57)
	(at pallet1 depot1)
	(clear crate44)
	(at pallet2 depot2)
	(clear crate56)
	(at pallet3 distributor0)
	(clear crate54)
	(at pallet4 distributor1)
	(clear crate58)
	(at pallet5 distributor2)
	(clear crate59)
	(at pallet6 distributor2)
	(clear crate52)
	(at pallet7 depot0)
	(clear crate55)
	(at pallet8 distributor1)
	(clear crate42)
	(at pallet9 distributor2)
	(clear crate13)
	(at truck0 distributor1)
	(= (speed truck0) 1)
	(at truck1 depot0)
	(= (speed truck1) 5)
	(at truck2 depot0)
	(= (speed truck2) 8)
	(at truck3 depot1)
	(= (speed truck3) 8)
	(at truck4 depot2)
	(= (speed truck4) 2)
	(at truck5 distributor0)
	(= (speed truck5) 6)
	(at hoist0 depot0)
	(available hoist0)
	(= (power hoist0) 6)
	(at hoist1 depot1)
	(available hoist1)
	(= (power hoist1) 2)
	(at hoist2 depot2)
	(available hoist2)
	(= (power hoist2) 7)
	(at hoist3 distributor0)
	(available hoist3)
	(= (power hoist3) 2)
	(at hoist4 distributor1)
	(available hoist4)
	(= (power hoist4) 7)
	(at hoist5 distributor2)
	(available hoist5)
	(= (power hoist5) 3)
	(at hoist6 distributor2)
	(available hoist6)
	(= (power hoist6) 3)
	(at hoist7 distributor1)
	(available hoist7)
	(= (power hoist7) 1)
	(at hoist8 depot1)
	(available hoist8)
	(= (power hoist8) 9)
	(at hoist9 depot2)
	(available hoist9)
	(= (power hoist9) 4)
	(at crate0 distributor0)
	(on crate0 pallet3)
	(= (weight crate0) 1)
	(at crate1 distributor2)
	(on crate1 pallet9)
	(= (weight crate1) 1)
	(at crate2 distributor1)
	(on crate2 pallet4)
	(= (weight crate2) 1)
	(at crate3 depot2)
	(on crate3 pallet2)
	(= (weight crate3) 1)
	(at crate4 distributor2)
	(on crate4 pallet6)
	(= (weight crate4) 1)
	(at crate5 depot0)
	(on crate5 pallet0)
	(= (weight crate5) 1)
	(at crate6 distributor2)
	(on crate6 crate1)
	(= (weight crate6) 1)
	(at crate7 depot0)
	(on crate7 pallet7)
	(= (weight crate7) 1)
	(at crate8 distributor2)
	(on crate8 pallet5)
	(= (weight crate8) 1)
	(at crate9 distributor1)
	(on crate9 crate2)
	(= (weight crate9) 1)
	(at crate10 distributor0)
	(on crate10 crate0)
	(= (weight crate10) 1)
	(at crate11 distributor2)
	(on crate11 crate8)
	(= (weight crate11) 1)
	(at crate12 depot0)
	(on crate12 crate7)
	(= (weight crate12) 1)
	(at crate13 distributor2)
	(on crate13 crate6)
	(= (weight crate13) 1)
	(at crate14 distributor0)
	(on crate14 crate10)
	(= (weight crate14) 1)
	(at crate15 distributor2)
	(on crate15 crate4)
	(= (weight crate15) 1)
	(at crate16 distributor1)
	(on crate16 crate9)
	(= (weight crate16) 1)
	(at crate17 depot1)
	(on crate17 pallet1)
	(= (weight crate17) 1)
	(at crate18 depot1)
	(on crate18 crate17)
	(= (weight crate18) 1)
	(at crate19 distributor0)
	(on crate19 crate14)
	(= (weight crate19) 1)
	(at crate20 distributor0)
	(on crate20 crate19)
	(= (weight crate20) 1)
	(at crate21 depot0)
	(on crate21 crate12)
	(= (weight crate21) 1)
	(at crate22 depot0)
	(on crate22 crate21)
	(= (weight crate22) 1)
	(at crate23 depot2)
	(on crate23 crate3)
	(= (weight crate23) 1)
	(at crate24 depot1)
	(on crate24 crate18)
	(= (weight crate24) 1)
	(at crate25 depot2)
	(on crate25 crate23)
	(= (weight crate25) 1)
	(at crate26 distributor1)
	(on crate26 crate16)
	(= (weight crate26) 1)
	(at crate27 distributor2)
	(on crate27 crate11)
	(= (weight crate27) 1)
	(at crate28 distributor1)
	(on crate28 crate26)
	(= (weight crate28) 1)
	(at crate29 depot0)
	(on crate29 crate5)
	(= (weight crate29) 1)
	(at crate30 distributor1)
	(on crate30 crate28)
	(= (weight crate30) 1)
	(at crate31 distributor1)
	(on crate31 crate30)
	(= (weight crate31) 1)
	(at crate32 depot2)
	(on crate32 crate25)
	(= (weight crate32) 1)
	(at crate33 depot0)
	(on crate33 crate22)
	(= (weight crate33) 1)
	(at crate34 depot0)
	(on crate34 crate29)
	(= (weight crate34) 1)
	(at crate35 depot1)
	(on crate35 crate24)
	(= (weight crate35) 1)
	(at crate36 distributor2)
	(on crate36 crate15)
	(= (weight crate36) 1)
	(at crate37 distributor2)
	(on crate37 crate36)
	(= (weight crate37) 1)
	(at crate38 distributor1)
	(on crate38 crate31)
	(= (weight crate38) 1)
	(at crate39 depot0)
	(on crate39 crate33)
	(= (weight crate39) 1)
	(at crate40 distributor2)
	(on crate40 crate37)
	(= (weight crate40) 1)
	(at crate41 depot0)
	(on crate41 crate34)
	(= (weight crate41) 1)
	(at crate42 distributor1)
	(on crate42 pallet8)
	(= (weight crate42) 1)
	(at crate43 depot2)
	(on crate43 crate32)
	(= (weight crate43) 1)
	(at crate44 depot1)
	(on crate44 crate35)
	(= (weight crate44) 1)
	(at crate45 depot2)
	(on crate45 crate43)
	(= (weight crate45) 1)
	(at crate46 depot0)
	(on crate46 crate41)
	(= (weight crate46) 1)
	(at crate47 distributor1)
	(on crate47 crate38)
	(= (weight crate47) 1)
	(at crate48 depot2)
	(on crate48 crate45)
	(= (weight crate48) 1)
	(at crate49 distributor2)
	(on crate49 crate40)
	(= (weight crate49) 1)
	(at crate50 distributor1)
	(on crate50 crate47)
	(= (weight crate50) 1)
	(at crate51 depot0)
	(on crate51 crate39)
	(= (weight crate51) 1)
	(at crate52 distributor2)
	(on crate52 crate49)
	(= (weight crate52) 1)
	(at crate53 distributor1)
	(on crate53 crate50)
	(= (weight crate53) 1)
	(at crate54 distributor0)
	(on crate54 crate20)
	(= (weight crate54) 1)
	(at crate55 depot0)
	(on crate55 crate51)
	(= (weight crate55) 1)
	(at crate56 depot2)
	(on crate56 crate48)
	(= (weight crate56) 1)
	(at crate57 depot0)
	(on crate57 crate46)
	(= (weight crate57) 1)
	(at crate58 distributor1)
	(on crate58 crate53)
	(= (weight crate58) 1)
	(at crate59 distributor2)
	(on crate59 crate27)
	(= (weight crate59) 1)
	(= (distance depot0 depot0) 0)
	(= (distance depot0 depot1) 3)
	(= (distance depot0 depot2) 3)
	(= (distance depot0 distributor0) 9)
	(= (distance depot0 distributor1) 6)
	(= (distance depot0 distributor2) 3)
	(= (distance depot1 depot0) 4)
	(= (distance depot1 depot1) 0)
	(= (distance depot1 depot2) 4)
	(= (distance depot1 distributor0) 6)
	(= (distance depot1 distributor1) 5)
	(= (distance depot1 distributor2) 2)
	(= (distance depot2 depot0) 9)
	(= (distance depot2 depot1) 4)
	(= (distance depot2 depot2) 0)
	(= (distance depot2 distributor0) 2)
	(= (distance depot2 distributor1) 10)
	(= (distance depot2 distributor2) 2)
	(= (distance distributor0 depot0) 3)
	(= (distance distributor0 depot1) 5)
	(= (distance distributor0 depot2) 2)
	(= (distance distributor0 distributor0) 0)
	(= (distance distributor0 distributor1) 5)
	(= (distance distributor0 distributor2) 1)
	(= (distance distributor1 depot0) 7)
	(= (distance distributor1 depot1) 7)
	(= (distance distributor1 depot2) 6)
	(= (distance distributor1 distributor0) 3)
	(= (distance distributor1 distributor1) 0)
	(= (distance distributor1 distributor2) 7)
	(= (distance distributor2 depot0) 3)
	(= (distance distributor2 depot1) 4)
	(= (distance distributor2 depot2) 9)
	(= (distance distributor2 distributor0) 5)
	(= (distance distributor2 distributor1) 3)
	(= (distance distributor2 distributor2) 0)
)

(:goal (and
		(on crate0 crate50)
		(on crate1 crate25)
		(on crate3 pallet3)
		(on crate5 crate22)
		(on crate6 crate12)
		(on crate7 crate27)
		(on crate8 crate1)
		(on crate10 crate54)
		(on crate11 crate45)
		(on crate12 pallet9)
		(on crate13 crate18)
		(on crate14 crate42)
		(on crate15 crate36)
		(on crate16 crate31)
		(on crate18 crate59)
		(on crate19 crate58)
		(on crate20 crate43)
		(on crate21 crate33)
		(on crate22 crate16)
		(on crate23 crate46)
		(on crate24 crate8)
		(on crate25 pallet7)
		(on crate27 crate38)
		(on crate30 crate55)
		(on crate31 pallet8)
		(on crate32 pallet6)
		(on crate33 pallet2)
		(on crate34 crate35)
		(on crate35 crate14)
		(on crate36 crate30)
		(on crate37 crate49)
		(on crate38 pallet0)
		(on crate40 crate7)
		(on crate42 crate20)
		(on crate43 pallet4)
		(on crate45 pallet1)
		(on crate46 crate51)
		(on crate48 crate23)
		(on crate49 crate3)
		(on crate50 crate6)
		(on crate51 crate37)
		(on crate52 crate19)
		(on crate53 crate13)
		(on crate54 pallet5)
		(on crate55 crate32)
		(on crate57 crate11)
		(on crate58 crate10)
		(on crate59 crate21)
	)
)

(:metric minimize (total-time)))