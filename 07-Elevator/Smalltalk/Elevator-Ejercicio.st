!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #CabinDoor category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoor
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:14:41'!
close

	state closeCabinDoor: self! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:13:51'!
closeWhenClosed! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:13:57'!
closeWhenClosing! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:14:07'!
closeWhenOpened

	state := CabinDoorStateClosing new.! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:14:16'!
closeWhenOpening! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:04:54'!
closed

	state := CabinDoorStateClosed new.! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:56:56'!
initialize

	state := CabinDoorStateOpened new.! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:18:51'!
isClosed

	^ state isClosed ! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:20:17'!
isClosing

	^ state isClosing! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:21:23'!
isOpened

	^ state isOpened! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:21:57'!
isOpening

	^ state isOpening! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:28:47'!
open

	state openCabinDoor: self! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:40:02'!
openWhenClosed

	state := CabinDoorStateOpening new! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:31:56'!
openWhenClosing

	state := CabinDoorStateOpening new! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:33:04'!
openWhenOpened! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:31:18'!
openWhenOpening! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:07:42'!
opened

	state := CabinDoorStateOpened new.! !


!classDefinition: #CabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:14:59'!
closeCabinDoor: aCabinDoor

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:32:32'!
isClosed

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:32:28'!
isClosing

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:32:06'!
isOpened

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:32:20'!
isOpening

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:14:51'!
openCabinDoor: aCabinDoor

	self subclassResponsibility ! !


!classDefinition: #CabinDoorStateClosed category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorStateClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:15:20'!
closeCabinDoor: aCabinDoor

	aCabinDoor closeWhenClosed ! !

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:34:31'!
isClosed

	^ true! !

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:06'!
isClosing

	^ false! !

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:12'!
isOpened

	^ false! !

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:16'!
isOpening

	^ false! !

!CabinDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:30:09'!
openCabinDoor: aCabinDoor

	aCabinDoor openWhenClosed! !


!classDefinition: #CabinDoorStateClosing category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorStateClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:15:28'!
closeCabinDoor: aCabinDoor

	aCabinDoor closeWhenClosing! !

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:28'!
isClosed

	^ false! !

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:46'!
isClosing

	^ true! !

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:36'!
isOpened

	^ false! !

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:38'!
isOpening

	^ false! !

!CabinDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:29:46'!
openCabinDoor: aCabinDoor

	aCabinDoor openWhenClosing! !


!classDefinition: #CabinDoorStateOpened category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorStateOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:15:36'!
closeCabinDoor: aCabinDoor

	aCabinDoor closeWhenOpened! !

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:06'!
isClosed

	^ false! !

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:08'!
isClosing

	^ false! !

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:36:56'!
isOpened

	^ true! !

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:03'!
isOpening

	^ false! !

!CabinDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:30:32'!
openCabinDoor: aCabinDoor

	aCabinDoor openWhenOpened! !


!classDefinition: #CabinDoorStateOpening category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorStateOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:15:47'!
closeCabinDoor: aCabinDoor

	aCabinDoor closeWhenOpening! !

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:39'!
isClosed

	^ false! !

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:41'!
isClosing

	^ false! !

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:36'!
isOpened

	^ false! !

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:30'!
isOpening

	^ true! !

!CabinDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:30:53'!
openCabinDoor: aCabinDoor

	aCabinDoor openWhenOpening! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:04:47'!
closeDoorFromCabin: anElevatorCabin

	self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:33:34'!
isMoving

	self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:33:26'!
isStopped

	self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:08:32'!
isWaitingForPeople

	self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:46:02'!
onFloor: aFloorNumber fromElevatorController: anElevatorController fromCabin: anElevatorCabin

	self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:42:48'!
openDoor: anElevatorCabin

	self subclassResponsibility ! !


!classDefinition: #CabinStateMoving category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStateMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:05:21'!
closeDoorFromCabin: anElevatorCabin

	anElevatorCabin closeDoorWhenMoving ! !

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:37:57'!
isMoving

	^ true! !

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:38:02'!
isStopped

	^ false! !

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:08:44'!
isWaitingForPeople

	^ false! !

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:46:26'!
onFloor: aFloorNumber fromElevatorController: anElevatorController fromCabin: anElevatorCabin

	anElevatorCabin movingOnFloor: aFloorNumber fromElevatorController: anElevatorController ! !

!CabinStateMoving methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:43:17'!
openDoor: anElevatorCabin

	anElevatorCabin openWhenMoving ! !


!classDefinition: #CabinStateStopped category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStateStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:05:32'!
closeDoorFromCabin: anElevatorCabin

	anElevatorCabin closeDoorWhenStopped ! !

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:38:20'!
isMoving

	^ false! !

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:38:26'!
isStopped

	^ true! !

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:08:57'!
isWaitingForPeople

	^ false! !

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:46:46'!
onFloor: aFloorNumber fromElevatorController: anElevatorController fromCabin: anElevatorCabin

	anElevatorCabin stoppedOnFloor: aFloorNumber fromElevatorController: anElevatorController ! !

!CabinStateStopped methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:43:26'!
openDoor: anElevatorCabin

	anElevatorCabin openWhenStopped ! !


!classDefinition: #CabinStateWaitingForPeople category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStateWaitingForPeople
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:05:38'!
closeDoorFromCabin: anElevatorCabin

	anElevatorCabin closeDoorWhenWaitingForPeople ! !

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:08:10'!
isMoving

	^ false! !

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:08:21'!
isStopped

	^ false! !

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 20:09:03'!
isWaitingForPeople

	^ true! !

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:46:55'!
onFloor: aFloorNumber fromElevatorController: anElevatorController fromCabin: anElevatorCabin

	anElevatorCabin waitingForPeopleOnFloor: aFloorNumber fromElevatorController: anElevatorController ! !

!CabinStateWaitingForPeople methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:43:35'!
openDoor: anElevatorCabin

	anElevatorCabin openWhenWaitingForPeople ! !


!classDefinition: #ElevatorCabin category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabin
	instanceVariableNames: 'state door'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:05:02'!
closeDoor

	state closeDoorFromCabin: self! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:02:34'!
closeDoorWhenMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:02:51'!
closeDoorWhenStopped

	door close! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:53:32'!
closeDoorWhenWaitingForPeople

	self stopWaitingForPeople ! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:37:43'!
doorClosed

	state := CabinStateMoving new."deberia estar aca?"
	door closed! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:38:27'!
doorOpenedWithPeopleWaiting

	state := CabinStateWaitingForPeople new.
	door opened! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:38:31'!
doorOpenedWithoutPeopleWaiting

	state := CabinStateStopped new.
	door opened! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:34:25'!
initialize

	state _ CabinStateStopped new.
	door _ CabinDoor new.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:18:35'!
isDoorClosed

	^ door isClosed! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:20:02'!
isDoorClosing

	^ door isClosing! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:21:09'!
isDoorOpened

	^ door isOpened! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:21:46'!
isDoorOpening

	^ door isOpening! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:22:15'!
isMoving

	^ state isMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:22:46'!
isStopped

	^ state isStopped! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:23:06'!
isWaitingForPeople

	^ state isWaitingForPeople ! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:37:09'!
movingOnFloor: aFloorNumber fromElevatorController: anElevatorController

	anElevatorController movingCabinOnFloor: aFloorNumber ! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:45:45'!
onFloor: aFloorNumber fromElevatorController: anElevatorController

	state onFloor: aFloorNumber fromElevatorController: anElevatorController fromCabin: self! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:41:31'!
openDoor

	state openDoor: self! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:41:45'!
openWhenMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:41:52'!
openWhenStopped

	door open! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:42:05'!
openWhenWaitingForPeople

	door open! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:10:49'!
stop

	state := CabinStateStopped new.
	door open! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:44:05'!
stopWaitingForPeople
	
	state := CabinStateStopped new.
	self closeDoor! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:37:24'!
stoppedOnFloor: aFloorNumber fromElevatorController: anElevatorController

	anElevatorController stoppedCabinOnFloor: aFloorNumber ! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:37:35'!
waitingForPeopleOnFloor: aFloorNumber fromElevatorController: anElevatorController

	anElevatorController waitingForPeopleCabinOnFloor: aFloorNumber ! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'cabin state cabinFloorNumber targetFloor floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:04:02'!
cabinDoorClosed
	
	state := ElevatorControllerStateWorking new.
	cabin doorClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 20:08:32'!
cabinDoorOpened
	
	(floorsToGo size = 1) ifTrue: [
		state := ElevatorControllerStateIdle new.
		cabin doorOpenedWithoutPeopleWaiting ] 
	ifFalse: [ 
		"targetFloor := "floorsToGo removeFirst.
		state := ElevatorControllerStateWorking new.
		cabin doorOpenedWithPeopleWaiting ].! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:42:48'!
cabinFloorNumber

	^ cabinFloorNumber ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:32:03'!
cabinOnFloor: aFloorNumber

	cabin onFloor: aFloorNumber fromElevatorController: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:46:59'!
closeCabinDoor
	
	state closeCabinDoorFromElevatorController: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:48:39'!
closeCabinDoorWhenIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:01:23'!
closeCabinDoorWhenWorking

	cabin closeDoor ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:26:34'!
goUpPushedFromFloor: aFloorNumber 
	
	state goUpPushedFromFloor: aFloorNumber onElevatorController: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 20:02:11'!
goUpPushedWhenIdleFromFloor: aFloorNumber

	state := ElevatorControllerStateWorking new.
	"targetFloor := aFloorNumber."
	floorsToGo add: aFloorNumber.
	self closeCabinDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:59:47'!
goUpPushedWhenWorkingFromFloor: aFloorNumber

	floorsToGo add: aFloorNumber.
	cabin closeDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:57:58'!
initialize

	state := ElevatorControllerStateIdle new.
	cabin := ElevatorCabin new.
	cabinFloorNumber := 0.
	floorsToGo := SortedCollection new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:18:14'!
isCabinDoorClosed
	
	^ cabin isDoorClosed ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:19:44'!
isCabinDoorClosing
	
	^ cabin isDoorClosing! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:20:51'!
isCabinDoorOpened

	^ cabin isDoorOpened ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:21:33'!
isCabinDoorOpening
	
	^ cabin isDoorOpening ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:22:04'!
isCabinMoving
	
	^ cabin isMoving ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:22:21'!
isCabinStopped

	^ cabin isStopped ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:22:54'!
isCabinWaitingForPeople
	
	^ cabin isWaitingForPeople ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:43:32'!
isIdle
	
	^ state isIdle ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:43:37'!
isWorking

	^ state isWorking ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 20:17:35'!
movingCabinOnFloor: aFloorNumber

	((cabinFloorNumber - aFloorNumber) abs = 1) ifFalse: [ ElevatorEmergency signal: 'Sensor de cabina desincronizado' ].
	cabinFloorNumber := aFloorNumber.
	((floorsToGo at: 1) = aFloorNumber) ifTrue: [ cabin stop ]! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 21:23:50'!
openCabinDoor
	
	cabin openDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:49:37'!
stoppedCabinOnFloor: aFloorNumber

	ElevatorEmergency signal: 'Sensor de cabina desincronizado'.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:44:15'!
waitForPeopleTimedOut
	
	cabin stopWaitingForPeople! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 19:49:41'!
waitingForPeopleCabinOnFloor: aFloorNumber

	ElevatorEmergency signal: 'Sensor de cabina desincronizado'.! !


!classDefinition: #ElevatorControllerState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:47:20'!
closeCabinDoorFromElevatorController: anElevatorController

	self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:23:30'!
goUpPushedFromFloor: aFloorNumber onElevatorController: anElevatorController

	self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:27:28'!
isIdle

	self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:27:38'!
isWorking

	self subclassResponsibility ! !


!classDefinition: #ElevatorControllerStateIdle category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerStateIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:47:46'!
closeCabinDoorFromElevatorController: anElevatorController

	anElevatorController closeCabinDoorWhenIdle! !

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:24:04'!
goUpPushedFromFloor: aFloorNumber onElevatorController: anElevatorController

	anElevatorController goUpPushedWhenIdleFromFloor: aFloorNumber ! !

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:38:48'!
isIdle

	^ true! !

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:39:06'!
isWorking

	^ false! !


!classDefinition: #ElevatorControllerStateWorking category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerStateWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:48:23'!
closeCabinDoorFromElevatorController: anElevatorController

	anElevatorController closeCabinDoorWhenWorking! !

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'GJC 10/10/2017 18:24:16'!
goUpPushedFromFloor: aFloorNumber onElevatorController: anElevatorController

	anElevatorController goUpPushedWhenWorkingFromFloor: aFloorNumber ! !

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:39:32'!
isIdle

	^ false! !

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'ST 10/2/2017 18:39:49'!
isWorking

	^ true! !
