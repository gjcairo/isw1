!classDefinition: #CarritoException category: #TusLibros!
Exception subclass: #CarritoException
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarritoException class' category: #TusLibros!
CarritoException class
	instanceVariableNames: ''!

!CarritoException class methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:11:50'!
invalidAmountException

	self signal: 'La cantidad debe ser entera y mayor a cero'.! !

!CarritoException class methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 20:32:14'!
invalidItemException

	self signal: 'El item no esta en el catalogo'.! !


!classDefinition: #CarritoTest category: #TusLibros!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'owner name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 20:22:10'!
test01AlCrearUnCarritoElCarritoEstaVacio

	| aCarrito aCatalog |
	
	aCatalog := Set new.
	aCarrito := Carrito for: aCatalog.
	
	self assert: aCarrito isEmpty.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:37:37'!
test02AlAgregarItemAlCarritoElCarritoNoEstaVacio

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Set with: anItem.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	
	self deny: aCarrito isEmpty.
	self assert: aCarrito numberOfProducts = 1.
	self assert: (aCarrito items includes: anItem)! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:40:08'!
test03ElCarritoNoPermiteAgregarItemsInvalidos

	| aCatalog aCarrito anItem |
	
	aCatalog := Set new.
	aCarrito := Carrito for: aCatalog.
	anItem := 'yogurt'.
	
	self should: [ aCarrito add: anItem ] raise: CarritoException withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidItemErrorMessage.
		self assert: aCarrito isEmpty. ].! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:42:00'!
test04ElCarritoSoloPermiteAgregarCantidadesEnterasYPositivas

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Set with: anItem.
	aCarrito := Carrito for: aCatalog.
	
	self should: [ aCarrito add: anItem amount: 0] raise: CarritoException withExceptionDo: [ :anError | 
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].
	self should: [ aCarrito add: anItem amount: -1 ] raise: CarritoException withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].
	self should: [ aCarrito add: anItem amount: 2.3 ] raise: CarritoException withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:52:25'!
test05ElCarritoGuardaLaCantidadCorrectaDeCadaItem

	| aCatalog aCarrito anItem anotherItem |
	
	anItem := 'yogurt'.
	anotherItem := 'oreo'.
	aCatalog := Set withAll: {anItem. anotherItem}.
	aCarrito := Carrito for: aCatalog.
	
	aCarrito add: anItem amount: 10.
	aCarrito add: anotherItem.
	
	self assert: aCarrito numberOfProducts = 11.
	self assert: (aCarrito amountOf: anItem) = 10.
	self assert: (aCarrito amountOf: anotherItem) = 1.! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:11:18'!
add: anItem

	self add: anItem amount: 1! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:29:50'!
add: anItem amount: anAmount

	(catalog includes: anItem) ifFalse: [ self error: (CarritoException invalidItemException) ].
	(anAmount isInteger and: [ anAmount > 0 ]) ifFalse: [ self error: (CarritoException invalidAmountException) ].
	
	items at: anItem put: anAmount ! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:51:52'!
amountOf: anItem

	^ items at: anItem! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:27:44'!
initializeWith: aCatalog

	items := Dictionary new.
	catalog := aCatalog ! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:41:21'!
invalidAmountErrorMessage

	^ 'La cantidad debe ser entera y mayor a cero'! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:40:21'!
invalidItemErrorMessage

	^ 'El item no esta en el catalogo'! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 19:51:43'!
isEmpty

	^ items isEmpty ! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:42:33'!
items

	^ items keys! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:37:12'!
numberOfProducts

	^ items values sum! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 20:16:05'!
for: aCatalog

	^ self new initializeWith: aCatalog ! !
