!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:38:55'!
initialize

	top _ OOStackBase new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/15/2017 01:58:42'!
isEmpty

	^top isEmpty! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:27:11'!
pop
	
	| poppedElement |
	
	poppedElement := self top.
	top := top previousElement.
	^poppedElement ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:28:00'!
push: anObject

	top _ OOStackElement new initializeWith: anObject onTopOf: top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:43:40'!
size

	^top position! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:28:25'!
top
	
	^top value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
Object subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GJC 9/15/2017 02:05:19'!
isEmpty

	^true! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:43:26'!
position

	^0! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:24:48'!
previousElement

	self error: OOStack stackEmptyErrorDescription ! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:28:48'!
value

	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'elementValue previousElement position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:47:12'!
initializeWith: anObject onTopOf: anOOStackElement 
	
	elementValue := anObject.
	previousElement := anOOStackElement.
	position := previousElement position + 1! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'GJC 9/15/2017 02:05:13'!
isEmpty

	^false! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:43:13'!
position

	^position! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:20:05'!
previousElement

	^previousElement ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'GJC 9/16/2017 18:29:30'!
value

	^elementValue ! !
