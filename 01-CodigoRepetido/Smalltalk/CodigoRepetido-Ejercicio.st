!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:28:50'!
checkRunningTimeOf: aBlock isLesserThan: aTimeMeasure

	^ ( self measureRunningTimeOf: aBlock ) < aTimeMeasure ! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:47:29'!
makeSureBlockErrors: aBlockThatShouldError satisfying: aBlockWithConditionsThatMustHold

	[ aBlockThatShouldError value.
	self fail ]
		on: Error 
		do: aBlockWithConditionsThatMustHold ! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:28:20'!
measureRunningTimeOf: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning _ Time millisecondClockValue.
	aBlock value.
	millisecondsAfterRunning _ Time millisecondClockValue.

	^ millisecondsAfterRunning - millisecondsBeforeRunning.! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:29:52'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook _ CustomerBook new.
	
	self assert: (self checkRunningTimeOf: [ customerBook addCustomerNamed: 'John Lennon' ] isLesserThan: 50*millisecond ).! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:30:02'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |

	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self checkRunningTimeOf: [ customerBook removeCustomerNamed: paulMcCartney ] isLesserThan: 100 * millisecond).! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:44:19'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self makeSureBlockErrors: [ customerBook addCustomerNamed: ''. ] satisfying: [ :anError | 
																								self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
																								self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'GJC 9/5/2017 22:45:49'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	
	self makeSureBlockErrors: [ customerBook removeCustomerNamed: 'Paul McCartney' ] satisfying: [ :anError |
																														self assert: customerBook numberOfCustomers = 1.
																														self assert: (customerBook includesCustomerNamed: johnLennon) ].! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'GJC 9/5/2017 22:43:36'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
