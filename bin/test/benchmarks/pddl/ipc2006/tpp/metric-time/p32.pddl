(define (problem pfile32)
(:domain TPP-MetricTime)
(:objects
	market1 market2 market3 market4 market5 market6 market7 market8 - market
	depot1 depot2 depot3 depot4 - depot
	truck1 truck2 truck3 truck4 truck5 truck6 truck7 truck8 - truck
	goods1 goods2 goods3 goods4 goods5 goods6 goods7 goods8 goods9 goods10 goods11 goods12 goods13 goods14 goods15 goods16 goods17 - goods)

(:init
	(= (price goods1 market1) 49)
	(= (ready-to-load goods1 market1) 0)
	(= (on-sale goods1 market1) 17)
	(= (ready-to-load goods1 market2) 0)
	(= (on-sale goods1 market2) 0)
	(= (ready-to-load goods1 market3) 0)
	(= (on-sale goods1 market3) 0)
	(= (price goods1 market4) 15)
	(= (ready-to-load goods1 market4) 0)
	(= (on-sale goods1 market4) 16)
	(= (ready-to-load goods1 market5) 0)
	(= (on-sale goods1 market5) 0)
	(= (ready-to-load goods1 market6) 0)
	(= (on-sale goods1 market6) 0)
	(= (ready-to-load goods1 market7) 0)
	(= (on-sale goods1 market7) 0)
	(= (price goods1 market8) 24)
	(= (ready-to-load goods1 market8) 0)
	(= (on-sale goods1 market8) 4)
	(= (ready-to-load goods2 market1) 0)
	(= (on-sale goods2 market1) 0)
	(= (price goods2 market2) 14)
	(= (ready-to-load goods2 market2) 0)
	(= (on-sale goods2 market2) 4)
	(= (ready-to-load goods2 market3) 0)
	(= (on-sale goods2 market3) 0)
	(= (price goods2 market4) 18)
	(= (ready-to-load goods2 market4) 0)
	(= (on-sale goods2 market4) 17)
	(= (price goods2 market5) 17)
	(= (ready-to-load goods2 market5) 0)
	(= (on-sale goods2 market5) 3)
	(= (ready-to-load goods2 market6) 0)
	(= (on-sale goods2 market6) 0)
	(= (ready-to-load goods2 market7) 0)
	(= (on-sale goods2 market7) 0)
	(= (price goods2 market8) 9)
	(= (ready-to-load goods2 market8) 0)
	(= (on-sale goods2 market8) 20)
	(= (price goods3 market1) 15)
	(= (ready-to-load goods3 market1) 0)
	(= (on-sale goods3 market1) 18)
	(= (price goods3 market2) 11)
	(= (ready-to-load goods3 market2) 0)
	(= (on-sale goods3 market2) 15)
	(= (ready-to-load goods3 market3) 0)
	(= (on-sale goods3 market3) 0)
	(= (price goods3 market4) 12)
	(= (ready-to-load goods3 market4) 0)
	(= (on-sale goods3 market4) 5)
	(= (ready-to-load goods3 market5) 0)
	(= (on-sale goods3 market5) 0)
	(= (price goods3 market6) 47)
	(= (ready-to-load goods3 market6) 0)
	(= (on-sale goods3 market6) 3)
	(= (price goods3 market7) 24)
	(= (ready-to-load goods3 market7) 0)
	(= (on-sale goods3 market7) 11)
	(= (price goods3 market8) 32)
	(= (ready-to-load goods3 market8) 0)
	(= (on-sale goods3 market8) 16)
	(= (ready-to-load goods4 market1) 0)
	(= (on-sale goods4 market1) 0)
	(= (price goods4 market2) 36)
	(= (ready-to-load goods4 market2) 0)
	(= (on-sale goods4 market2) 1)
	(= (price goods4 market3) 36)
	(= (ready-to-load goods4 market3) 0)
	(= (on-sale goods4 market3) 8)
	(= (ready-to-load goods4 market4) 0)
	(= (on-sale goods4 market4) 0)
	(= (price goods4 market5) 8)
	(= (ready-to-load goods4 market5) 0)
	(= (on-sale goods4 market5) 5)
	(= (ready-to-load goods4 market6) 0)
	(= (on-sale goods4 market6) 0)
	(= (price goods4 market7) 1)
	(= (ready-to-load goods4 market7) 0)
	(= (on-sale goods4 market7) 2)
	(= (price goods4 market8) 13)
	(= (ready-to-load goods4 market8) 0)
	(= (on-sale goods4 market8) 12)
	(= (ready-to-load goods5 market1) 0)
	(= (on-sale goods5 market1) 0)
	(= (price goods5 market2) 3)
	(= (ready-to-load goods5 market2) 0)
	(= (on-sale goods5 market2) 16)
	(= (ready-to-load goods5 market3) 0)
	(= (on-sale goods5 market3) 0)
	(= (ready-to-load goods5 market4) 0)
	(= (on-sale goods5 market4) 0)
	(= (price goods5 market5) 40)
	(= (ready-to-load goods5 market5) 0)
	(= (on-sale goods5 market5) 7)
	(= (ready-to-load goods5 market6) 0)
	(= (on-sale goods5 market6) 0)
	(= (price goods5 market7) 8)
	(= (ready-to-load goods5 market7) 0)
	(= (on-sale goods5 market7) 7)
	(= (price goods5 market8) 10)
	(= (ready-to-load goods5 market8) 0)
	(= (on-sale goods5 market8) 18)
	(= (price goods6 market1) 27)
	(= (ready-to-load goods6 market1) 0)
	(= (on-sale goods6 market1) 15)
	(= (price goods6 market2) 12)
	(= (ready-to-load goods6 market2) 0)
	(= (on-sale goods6 market2) 4)
	(= (price goods6 market3) 3)
	(= (ready-to-load goods6 market3) 0)
	(= (on-sale goods6 market3) 11)
	(= (price goods6 market4) 6)
	(= (ready-to-load goods6 market4) 0)
	(= (on-sale goods6 market4) 4)
	(= (price goods6 market5) 18)
	(= (ready-to-load goods6 market5) 0)
	(= (on-sale goods6 market5) 15)
	(= (ready-to-load goods6 market6) 0)
	(= (on-sale goods6 market6) 0)
	(= (price goods6 market7) 30)
	(= (ready-to-load goods6 market7) 0)
	(= (on-sale goods6 market7) 4)
	(= (price goods6 market8) 30)
	(= (ready-to-load goods6 market8) 0)
	(= (on-sale goods6 market8) 13)
	(= (price goods7 market1) 5)
	(= (ready-to-load goods7 market1) 0)
	(= (on-sale goods7 market1) 5)
	(= (ready-to-load goods7 market2) 0)
	(= (on-sale goods7 market2) 0)
	(= (ready-to-load goods7 market3) 0)
	(= (on-sale goods7 market3) 0)
	(= (ready-to-load goods7 market4) 0)
	(= (on-sale goods7 market4) 0)
	(= (ready-to-load goods7 market5) 0)
	(= (on-sale goods7 market5) 0)
	(= (price goods7 market6) 39)
	(= (ready-to-load goods7 market6) 0)
	(= (on-sale goods7 market6) 2)
	(= (price goods7 market7) 24)
	(= (ready-to-load goods7 market7) 0)
	(= (on-sale goods7 market7) 10)
	(= (price goods7 market8) 33)
	(= (ready-to-load goods7 market8) 0)
	(= (on-sale goods7 market8) 1)
	(= (ready-to-load goods8 market1) 0)
	(= (on-sale goods8 market1) 0)
	(= (price goods8 market2) 27)
	(= (ready-to-load goods8 market2) 0)
	(= (on-sale goods8 market2) 17)
	(= (ready-to-load goods8 market3) 0)
	(= (on-sale goods8 market3) 0)
	(= (ready-to-load goods8 market4) 0)
	(= (on-sale goods8 market4) 0)
	(= (ready-to-load goods8 market5) 0)
	(= (on-sale goods8 market5) 0)
	(= (ready-to-load goods8 market6) 0)
	(= (on-sale goods8 market6) 0)
	(= (price goods8 market7) 35)
	(= (ready-to-load goods8 market7) 0)
	(= (on-sale goods8 market7) 5)
	(= (price goods8 market8) 50)
	(= (ready-to-load goods8 market8) 0)
	(= (on-sale goods8 market8) 17)
	(= (price goods9 market1) 4)
	(= (ready-to-load goods9 market1) 0)
	(= (on-sale goods9 market1) 7)
	(= (price goods9 market2) 34)
	(= (ready-to-load goods9 market2) 0)
	(= (on-sale goods9 market2) 6)
	(= (ready-to-load goods9 market3) 0)
	(= (on-sale goods9 market3) 0)
	(= (ready-to-load goods9 market4) 0)
	(= (on-sale goods9 market4) 0)
	(= (price goods9 market5) 36)
	(= (ready-to-load goods9 market5) 0)
	(= (on-sale goods9 market5) 1)
	(= (ready-to-load goods9 market6) 0)
	(= (on-sale goods9 market6) 0)
	(= (price goods9 market7) 23)
	(= (ready-to-load goods9 market7) 0)
	(= (on-sale goods9 market7) 9)
	(= (price goods9 market8) 7)
	(= (ready-to-load goods9 market8) 0)
	(= (on-sale goods9 market8) 1)
	(= (price goods10 market1) 33)
	(= (ready-to-load goods10 market1) 0)
	(= (on-sale goods10 market1) 10)
	(= (price goods10 market2) 38)
	(= (ready-to-load goods10 market2) 0)
	(= (on-sale goods10 market2) 10)
	(= (ready-to-load goods10 market3) 0)
	(= (on-sale goods10 market3) 0)
	(= (ready-to-load goods10 market4) 0)
	(= (on-sale goods10 market4) 0)
	(= (ready-to-load goods10 market5) 0)
	(= (on-sale goods10 market5) 0)
	(= (price goods10 market6) 31)
	(= (ready-to-load goods10 market6) 0)
	(= (on-sale goods10 market6) 6)
	(= (price goods10 market7) 9)
	(= (ready-to-load goods10 market7) 0)
	(= (on-sale goods10 market7) 16)
	(= (price goods10 market8) 17)
	(= (ready-to-load goods10 market8) 0)
	(= (on-sale goods10 market8) 20)
	(= (price goods11 market1) 14)
	(= (ready-to-load goods11 market1) 0)
	(= (on-sale goods11 market1) 7)
	(= (price goods11 market2) 50)
	(= (ready-to-load goods11 market2) 0)
	(= (on-sale goods11 market2) 8)
	(= (price goods11 market3) 10)
	(= (ready-to-load goods11 market3) 0)
	(= (on-sale goods11 market3) 10)
	(= (price goods11 market4) 1)
	(= (ready-to-load goods11 market4) 0)
	(= (on-sale goods11 market4) 4)
	(= (price goods11 market5) 32)
	(= (ready-to-load goods11 market5) 0)
	(= (on-sale goods11 market5) 16)
	(= (ready-to-load goods11 market6) 0)
	(= (on-sale goods11 market6) 0)
	(= (ready-to-load goods11 market7) 0)
	(= (on-sale goods11 market7) 0)
	(= (price goods11 market8) 20)
	(= (ready-to-load goods11 market8) 0)
	(= (on-sale goods11 market8) 7)
	(= (ready-to-load goods12 market1) 0)
	(= (on-sale goods12 market1) 0)
	(= (ready-to-load goods12 market2) 0)
	(= (on-sale goods12 market2) 0)
	(= (price goods12 market3) 3)
	(= (ready-to-load goods12 market3) 0)
	(= (on-sale goods12 market3) 8)
	(= (ready-to-load goods12 market4) 0)
	(= (on-sale goods12 market4) 0)
	(= (price goods12 market5) 10)
	(= (ready-to-load goods12 market5) 0)
	(= (on-sale goods12 market5) 11)
	(= (price goods12 market6) 27)
	(= (ready-to-load goods12 market6) 0)
	(= (on-sale goods12 market6) 9)
	(= (price goods12 market7) 9)
	(= (ready-to-load goods12 market7) 0)
	(= (on-sale goods12 market7) 13)
	(= (price goods12 market8) 4)
	(= (ready-to-load goods12 market8) 0)
	(= (on-sale goods12 market8) 4)
	(= (ready-to-load goods13 market1) 0)
	(= (on-sale goods13 market1) 0)
	(= (ready-to-load goods13 market2) 0)
	(= (on-sale goods13 market2) 0)
	(= (ready-to-load goods13 market3) 0)
	(= (on-sale goods13 market3) 0)
	(= (ready-to-load goods13 market4) 0)
	(= (on-sale goods13 market4) 0)
	(= (price goods13 market5) 3)
	(= (ready-to-load goods13 market5) 0)
	(= (on-sale goods13 market5) 17)
	(= (ready-to-load goods13 market6) 0)
	(= (on-sale goods13 market6) 0)
	(= (ready-to-load goods13 market7) 0)
	(= (on-sale goods13 market7) 0)
	(= (price goods13 market8) 5)
	(= (ready-to-load goods13 market8) 0)
	(= (on-sale goods13 market8) 19)
	(= (ready-to-load goods14 market1) 0)
	(= (on-sale goods14 market1) 0)
	(= (ready-to-load goods14 market2) 0)
	(= (on-sale goods14 market2) 0)
	(= (ready-to-load goods14 market3) 0)
	(= (on-sale goods14 market3) 0)
	(= (ready-to-load goods14 market4) 0)
	(= (on-sale goods14 market4) 0)
	(= (ready-to-load goods14 market5) 0)
	(= (on-sale goods14 market5) 0)
	(= (ready-to-load goods14 market6) 0)
	(= (on-sale goods14 market6) 0)
	(= (ready-to-load goods14 market7) 0)
	(= (on-sale goods14 market7) 0)
	(= (price goods14 market8) 40)
	(= (ready-to-load goods14 market8) 0)
	(= (on-sale goods14 market8) 10)
	(= (ready-to-load goods15 market1) 0)
	(= (on-sale goods15 market1) 0)
	(= (ready-to-load goods15 market2) 0)
	(= (on-sale goods15 market2) 0)
	(= (ready-to-load goods15 market3) 0)
	(= (on-sale goods15 market3) 0)
	(= (price goods15 market4) 25)
	(= (ready-to-load goods15 market4) 0)
	(= (on-sale goods15 market4) 2)
	(= (ready-to-load goods15 market5) 0)
	(= (on-sale goods15 market5) 0)
	(= (ready-to-load goods15 market6) 0)
	(= (on-sale goods15 market6) 0)
	(= (ready-to-load goods15 market7) 0)
	(= (on-sale goods15 market7) 0)
	(= (price goods15 market8) 49)
	(= (ready-to-load goods15 market8) 0)
	(= (on-sale goods15 market8) 20)
	(= (ready-to-load goods16 market1) 0)
	(= (on-sale goods16 market1) 0)
	(= (ready-to-load goods16 market2) 0)
	(= (on-sale goods16 market2) 0)
	(= (price goods16 market3) 50)
	(= (ready-to-load goods16 market3) 0)
	(= (on-sale goods16 market3) 5)
	(= (price goods16 market4) 20)
	(= (ready-to-load goods16 market4) 0)
	(= (on-sale goods16 market4) 5)
	(= (ready-to-load goods16 market5) 0)
	(= (on-sale goods16 market5) 0)
	(= (price goods16 market6) 37)
	(= (ready-to-load goods16 market6) 0)
	(= (on-sale goods16 market6) 19)
	(= (ready-to-load goods16 market7) 0)
	(= (on-sale goods16 market7) 0)
	(= (price goods16 market8) 1)
	(= (ready-to-load goods16 market8) 0)
	(= (on-sale goods16 market8) 15)
	(= (ready-to-load goods17 market1) 0)
	(= (on-sale goods17 market1) 0)
	(= (price goods17 market2) 24)
	(= (ready-to-load goods17 market2) 0)
	(= (on-sale goods17 market2) 20)
	(= (ready-to-load goods17 market3) 0)
	(= (on-sale goods17 market3) 0)
	(= (price goods17 market4) 37)
	(= (ready-to-load goods17 market4) 0)
	(= (on-sale goods17 market4) 13)
	(= (ready-to-load goods17 market5) 0)
	(= (on-sale goods17 market5) 0)
	(= (ready-to-load goods17 market6) 0)
	(= (on-sale goods17 market6) 0)
	(= (ready-to-load goods17 market7) 0)
	(= (on-sale goods17 market7) 0)
	(= (price goods17 market8) 3)
	(= (ready-to-load goods17 market8) 0)
	(= (on-sale goods17 market8) 7)
	(connected market1 market3)
	(connected market3 market1)
	(= (drive-cost market1 market3) 200.00)
	(= (drive-cost market3 market1) 200.00)
	(= (drive-time market1 market3) 600.00)
	(= (drive-time market3 market1) 600.00)
	(connected market1 market5)
	(connected market5 market1)
	(= (drive-cost market1 market5) 413.00)
	(= (drive-cost market5 market1) 413.00)
	(= (drive-time market1 market5) 1239.00)
	(= (drive-time market5 market1) 1239.00)
	(connected market1 market6)
	(connected market6 market1)
	(= (drive-cost market1 market6) 233.00)
	(= (drive-cost market6 market1) 233.00)
	(= (drive-time market1 market6) 699.00)
	(= (drive-time market6 market1) 699.00)
	(connected market1 market8)
	(connected market8 market1)
	(= (drive-cost market1 market8) 135.00)
	(= (drive-cost market8 market1) 135.00)
	(= (drive-time market1 market8) 405.00)
	(= (drive-time market8 market1) 405.00)
	(connected market2 market3)
	(connected market3 market2)
	(= (drive-cost market2 market3) 462.00)
	(= (drive-cost market3 market2) 462.00)
	(= (drive-time market2 market3) 1386.00)
	(= (drive-time market3 market2) 1386.00)
	(connected market2 market4)
	(connected market4 market2)
	(= (drive-cost market2 market4) 28.00)
	(= (drive-cost market4 market2) 28.00)
	(= (drive-time market2 market4) 84.00)
	(= (drive-time market4 market2) 84.00)
	(connected market2 market5)
	(connected market5 market2)
	(= (drive-cost market2 market5) 81.00)
	(= (drive-cost market5 market2) 81.00)
	(= (drive-time market2 market5) 243.00)
	(= (drive-time market5 market2) 243.00)
	(connected market2 market6)
	(connected market6 market2)
	(= (drive-cost market2 market6) 804.00)
	(= (drive-cost market6 market2) 804.00)
	(= (drive-time market2 market6) 2412.00)
	(= (drive-time market6 market2) 2412.00)
	(connected market2 market7)
	(connected market7 market2)
	(= (drive-cost market2 market7) 636.00)
	(= (drive-cost market7 market2) 636.00)
	(= (drive-time market2 market7) 1908.00)
	(= (drive-time market7 market2) 1908.00)
	(connected market2 market8)
	(connected market8 market2)
	(= (drive-cost market2 market8) 911.00)
	(= (drive-cost market8 market2) 911.00)
	(= (drive-time market2 market8) 2733.00)
	(= (drive-time market8 market2) 2733.00)
	(connected market3 market6)
	(connected market6 market3)
	(= (drive-cost market3 market6) 778.00)
	(= (drive-cost market6 market3) 778.00)
	(= (drive-time market3 market6) 2334.00)
	(= (drive-time market6 market3) 2334.00)
	(connected market3 market7)
	(connected market7 market3)
	(= (drive-cost market3 market7) 456.00)
	(= (drive-cost market7 market3) 456.00)
	(= (drive-time market3 market7) 1368.00)
	(= (drive-time market7 market3) 1368.00)
	(connected market4 market8)
	(connected market8 market4)
	(= (drive-cost market4 market8) 986.00)
	(= (drive-cost market8 market4) 986.00)
	(= (drive-time market4 market8) 2958.00)
	(= (drive-time market8 market4) 2958.00)
	(connected market5 market6)
	(connected market6 market5)
	(= (drive-cost market5 market6) 817.00)
	(= (drive-cost market6 market5) 817.00)
	(= (drive-time market5 market6) 2451.00)
	(= (drive-time market6 market5) 2451.00)
	(connected market5 market8)
	(connected market8 market5)
	(= (drive-cost market5 market8) 661.00)
	(= (drive-cost market8 market5) 661.00)
	(= (drive-time market5 market8) 1983.00)
	(= (drive-time market8 market5) 1983.00)
	(connected market6 market7)
	(connected market7 market6)
	(= (drive-cost market6 market7) 607.00)
	(= (drive-cost market7 market6) 607.00)
	(= (drive-time market6 market7) 1821.00)
	(= (drive-time market7 market6) 1821.00)
	(connected market7 market8)
	(connected market8 market7)
	(= (drive-cost market7 market8) 678.00)
	(= (drive-cost market8 market7) 678.00)
	(= (drive-time market7 market8) 2034.00)
	(= (drive-time market8 market7) 2034.00)
	(connected depot1 market8)
	(connected market8 depot1)
	(= (drive-cost market8 depot1) 595.00)
	(= (drive-cost depot1 market8) 595.00)
	(= (drive-time market8 depot1) 1785.00)
	(= (drive-time depot1 market8) 1785.00)
	(connected depot2 market8)
	(connected market8 depot2)
	(= (drive-cost market8 depot2) 155.00)
	(= (drive-cost depot2 market8) 155.00)
	(= (drive-time market8 depot2) 465.00)
	(= (drive-time depot2 market8) 465.00)
	(connected depot3 market8)
	(connected market8 depot3)
	(= (drive-cost market8 depot3) 166.00)
	(= (drive-cost depot3 market8) 166.00)
	(= (drive-time market8 depot3) 498.00)
	(= (drive-time depot3 market8) 498.00)
	(connected depot4 market1)
	(connected market1 depot4)
	(= (drive-cost market1 depot4) 475.00)
	(= (drive-cost depot4 market1) 475.00)
	(= (drive-time market1 depot4) 1425.00)
	(= (drive-time depot4 market1) 1425.00)
	(= (loaded goods1 truck1) 0)
	(= (loaded goods2 truck1) 0)
	(= (loaded goods3 truck1) 0)
	(= (loaded goods4 truck1) 0)
	(= (loaded goods5 truck1) 0)
	(= (loaded goods6 truck1) 0)
	(= (loaded goods7 truck1) 0)
	(= (loaded goods8 truck1) 0)
	(= (loaded goods9 truck1) 0)
	(= (loaded goods10 truck1) 0)
	(= (loaded goods11 truck1) 0)
	(= (loaded goods12 truck1) 0)
	(= (loaded goods13 truck1) 0)
	(= (loaded goods14 truck1) 0)
	(= (loaded goods15 truck1) 0)
	(= (loaded goods16 truck1) 0)
	(= (loaded goods17 truck1) 0)
	(at truck1 depot3)
	(= (loaded goods1 truck2) 0)
	(= (loaded goods2 truck2) 0)
	(= (loaded goods3 truck2) 0)
	(= (loaded goods4 truck2) 0)
	(= (loaded goods5 truck2) 0)
	(= (loaded goods6 truck2) 0)
	(= (loaded goods7 truck2) 0)
	(= (loaded goods8 truck2) 0)
	(= (loaded goods9 truck2) 0)
	(= (loaded goods10 truck2) 0)
	(= (loaded goods11 truck2) 0)
	(= (loaded goods12 truck2) 0)
	(= (loaded goods13 truck2) 0)
	(= (loaded goods14 truck2) 0)
	(= (loaded goods15 truck2) 0)
	(= (loaded goods16 truck2) 0)
	(= (loaded goods17 truck2) 0)
	(at truck2 depot3)
	(= (loaded goods1 truck3) 0)
	(= (loaded goods2 truck3) 0)
	(= (loaded goods3 truck3) 0)
	(= (loaded goods4 truck3) 0)
	(= (loaded goods5 truck3) 0)
	(= (loaded goods6 truck3) 0)
	(= (loaded goods7 truck3) 0)
	(= (loaded goods8 truck3) 0)
	(= (loaded goods9 truck3) 0)
	(= (loaded goods10 truck3) 0)
	(= (loaded goods11 truck3) 0)
	(= (loaded goods12 truck3) 0)
	(= (loaded goods13 truck3) 0)
	(= (loaded goods14 truck3) 0)
	(= (loaded goods15 truck3) 0)
	(= (loaded goods16 truck3) 0)
	(= (loaded goods17 truck3) 0)
	(at truck3 depot4)
	(= (loaded goods1 truck4) 0)
	(= (loaded goods2 truck4) 0)
	(= (loaded goods3 truck4) 0)
	(= (loaded goods4 truck4) 0)
	(= (loaded goods5 truck4) 0)
	(= (loaded goods6 truck4) 0)
	(= (loaded goods7 truck4) 0)
	(= (loaded goods8 truck4) 0)
	(= (loaded goods9 truck4) 0)
	(= (loaded goods10 truck4) 0)
	(= (loaded goods11 truck4) 0)
	(= (loaded goods12 truck4) 0)
	(= (loaded goods13 truck4) 0)
	(= (loaded goods14 truck4) 0)
	(= (loaded goods15 truck4) 0)
	(= (loaded goods16 truck4) 0)
	(= (loaded goods17 truck4) 0)
	(at truck4 depot2)
	(= (loaded goods1 truck5) 0)
	(= (loaded goods2 truck5) 0)
	(= (loaded goods3 truck5) 0)
	(= (loaded goods4 truck5) 0)
	(= (loaded goods5 truck5) 0)
	(= (loaded goods6 truck5) 0)
	(= (loaded goods7 truck5) 0)
	(= (loaded goods8 truck5) 0)
	(= (loaded goods9 truck5) 0)
	(= (loaded goods10 truck5) 0)
	(= (loaded goods11 truck5) 0)
	(= (loaded goods12 truck5) 0)
	(= (loaded goods13 truck5) 0)
	(= (loaded goods14 truck5) 0)
	(= (loaded goods15 truck5) 0)
	(= (loaded goods16 truck5) 0)
	(= (loaded goods17 truck5) 0)
	(at truck5 depot3)
	(= (loaded goods1 truck6) 0)
	(= (loaded goods2 truck6) 0)
	(= (loaded goods3 truck6) 0)
	(= (loaded goods4 truck6) 0)
	(= (loaded goods5 truck6) 0)
	(= (loaded goods6 truck6) 0)
	(= (loaded goods7 truck6) 0)
	(= (loaded goods8 truck6) 0)
	(= (loaded goods9 truck6) 0)
	(= (loaded goods10 truck6) 0)
	(= (loaded goods11 truck6) 0)
	(= (loaded goods12 truck6) 0)
	(= (loaded goods13 truck6) 0)
	(= (loaded goods14 truck6) 0)
	(= (loaded goods15 truck6) 0)
	(= (loaded goods16 truck6) 0)
	(= (loaded goods17 truck6) 0)
	(at truck6 depot3)
	(= (loaded goods1 truck7) 0)
	(= (loaded goods2 truck7) 0)
	(= (loaded goods3 truck7) 0)
	(= (loaded goods4 truck7) 0)
	(= (loaded goods5 truck7) 0)
	(= (loaded goods6 truck7) 0)
	(= (loaded goods7 truck7) 0)
	(= (loaded goods8 truck7) 0)
	(= (loaded goods9 truck7) 0)
	(= (loaded goods10 truck7) 0)
	(= (loaded goods11 truck7) 0)
	(= (loaded goods12 truck7) 0)
	(= (loaded goods13 truck7) 0)
	(= (loaded goods14 truck7) 0)
	(= (loaded goods15 truck7) 0)
	(= (loaded goods16 truck7) 0)
	(= (loaded goods17 truck7) 0)
	(at truck7 depot4)
	(= (loaded goods1 truck8) 0)
	(= (loaded goods2 truck8) 0)
	(= (loaded goods3 truck8) 0)
	(= (loaded goods4 truck8) 0)
	(= (loaded goods5 truck8) 0)
	(= (loaded goods6 truck8) 0)
	(= (loaded goods7 truck8) 0)
	(= (loaded goods8 truck8) 0)
	(= (loaded goods9 truck8) 0)
	(= (loaded goods10 truck8) 0)
	(= (loaded goods11 truck8) 0)
	(= (loaded goods12 truck8) 0)
	(= (loaded goods13 truck8) 0)
	(= (loaded goods14 truck8) 0)
	(= (loaded goods15 truck8) 0)
	(= (loaded goods16 truck8) 0)
	(= (loaded goods17 truck8) 0)
	(at truck8 depot2)
	(= (stored goods1) 0)
	(= (stored goods2) 0)
	(= (stored goods3) 0)
	(= (stored goods4) 0)
	(= (stored goods5) 0)
	(= (stored goods6) 0)
	(= (stored goods7) 0)
	(= (stored goods8) 0)
	(= (stored goods9) 0)
	(= (stored goods10) 0)
	(= (stored goods11) 0)
	(= (stored goods12) 0)
	(= (stored goods13) 0)
	(= (stored goods14) 0)
	(= (stored goods15) 0)
	(= (stored goods16) 0)
	(= (stored goods17) 0)
	(= (total-cost) 0)
	(= (rebate-rate market1) 0.76)
	(= (rebate-rate market2) 0.84)
	(= (rebate-rate market3) 0.86)
	(= (rebate-rate market4) 0.76)
	(= (rebate-rate market5) 0.90)
	(= (rebate-rate market6) 0.76)
	(= (rebate-rate market7) 0.89)
	(= (rebate-rate market8) 0.86)
	(= (bought goods1) 0)
	(= (bought goods2) 0)
	(= (bought goods3) 0)
	(= (bought goods4) 0)
	(= (bought goods5) 0)
	(= (bought goods6) 0)
	(= (bought goods7) 0)
	(= (bought goods8) 0)
	(= (bought goods9) 0)
	(= (bought goods10) 0)
	(= (bought goods11) 0)
	(= (bought goods12) 0)
	(= (bought goods13) 0)
	(= (bought goods14) 0)
	(= (bought goods15) 0)
	(= (bought goods16) 0)
	(= (bought goods17) 0)
	(= (request goods1) 24)
	(= (request goods2) 16)
	(= (request goods3) 47)
	(= (request goods4) 20)
	(= (request goods5) 21)
	(= (request goods6) 9)
	(= (request goods7) 5)
	(= (request goods8) 28)
	(= (request goods9) 22)
	(= (request goods10) 39)
	(= (request goods11) 46)
	(= (request goods12) 1)
	(= (request goods13) 34)
	(= (request goods14) 9)
	(= (request goods15) 14)
	(= (request goods16) 8)
	(= (request goods17) 1))

(:goal (and
	(>= (stored goods1) (request goods1))
	(>= (stored goods2) (request goods2))
	(>= (stored goods3) (request goods3))
	(>= (stored goods4) (request goods4))
	(>= (stored goods5) (request goods5))
	(>= (stored goods6) (request goods6))
	(>= (stored goods7) (request goods7))
	(>= (stored goods8) (request goods8))
	(>= (stored goods9) (request goods9))
	(>= (stored goods10) (request goods10))
	(>= (stored goods11) (request goods11))
	(>= (stored goods12) (request goods12))
	(>= (stored goods13) (request goods13))
	(>= (stored goods14) (request goods14))
	(>= (stored goods15) (request goods15))
	(>= (stored goods16) (request goods16))
	(>= (stored goods17) (request goods17))))

(:metric minimize (+ (* 1.3 (total-cost))(total-time)))
)