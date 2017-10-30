!classDefinition: #CarritoTest category: #TusLibros!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:48:12'!
test01AlCrearUnCarritoElCarritoEstaVacio

	| aCarrito aCatalog |
	
	aCatalog := Dictionary new.
	aCarrito := Carrito for: aCatalog.
	
	self assert: aCarrito isEmpty.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:49:12'!
test02AlAgregarItemAlCarritoElCarritoNoEstaVacio

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	
	self deny: aCarrito isEmpty.
	self assert: aCarrito numberOfProducts = 1.
	self assert: (aCarrito items includes: anItem)! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:49:22'!
test03ElCarritoNoPermiteAgregarItemsInvalidos

	| aCatalog aCarrito anItem |
	
	aCatalog := Dictionary new.
	aCarrito := Carrito for: aCatalog.
	anItem := 'yogurt'.

	self should: [ aCarrito add: anItem ] raise: Error - MessageNotUnderstood withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidItemErrorMessage.
		self assert: aCarrito isEmpty. ].! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:49:41'!
test04ElCarritoSoloPermiteAgregarCantidadesEnterasYPositivas

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	
	self should: [ aCarrito add: anItem amount: 0] raise: Error - MessageNotUnderstood withExceptionDo: [ :anError | 
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].
	self should: [ aCarrito add: anItem amount: -1 ] raise: Error - MessageNotUnderstood  withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].
	self should: [ aCarrito add: anItem amount: 2.3 ] raise: Error - MessageNotUnderstood  withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidAmountErrorMessage.
		self assert: aCarrito isEmpty. ].! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:49:57'!
test05ElCarritoGuardaLaCantidadCorrectaDeCadaItem

	| aCatalog aCarrito anItem anotherItem |
	
	anItem := 'yogurt'.
	anotherItem := 'oreo'.
	aCatalog := Dictionary newFromPairs: {anItem. 10. anotherItem. 15.}.
	aCarrito := Carrito for: aCatalog.
	
	aCarrito add: anItem amount: 10.
	aCarrito add: anotherItem.
	
	self assert: aCarrito numberOfProducts = 11.
	self assert: (aCarrito amountOf: anItem) = 10.
	self assert: (aCarrito amountOf: anotherItem) = 1.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:44:46'!
test01NoEsPosibleHacerCheckoutDeCarritoVacio

	| aCatalog aCarrito aCashier aCreditCard |
	
	aCatalog := Dictionary new.
	aCarrito := Carrito for: aCatalog.
	aCashier := Cashier for: aCatalog.
	aCreditCard := CreditCard expiration: (Month current next).
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier emptyCartErrorMessage ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:45:51'!
test02CobroDeCarritoSolamenteConItemsUnitariosTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt'.
	aCarrito add: 'queso'.
	aCashier := Cashier for: aCatalog.
	aCreditCard := CreditCard expiration: (Month current next).
	
	self assert: (aCashier charge: aCreditCard for: aCarrito) = 45! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:46:05'!
test03CobroDeCarritoConDistintasUnidadesDeCadaItemTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aCashier := Cashier for: aCatalog.
	aCreditCard := CreditCard expiration: (Month current next).
	
	self assert: (aCashier charge: aCreditCard for: aCarrito) = 105! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:44:58'!
test04HacerCheckoutDeUnCarritoConItemsConUnaTarjetaVencidaHaceUnMesDebeFallar

	| aCatalog aCarrito aCashier aCreditCard |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aCashier := Cashier for: aCatalog.
	aCreditCard := CreditCard expiration: (Month current previous).
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier cardExpiredErrorMessage ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:47:17'!
test05HacerCheckoutDeUnCarritoConItemsConUnaTarjetaQueVenceEsteMesNoDebeFallar

	| aCatalog aCarrito aCashier aCreditCard |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aCashier := Cashier for: aCatalog.
	aCreditCard := CreditCard expiration: (Month current).
	
	self assert: (aCashier charge: aCreditCard for: aCarrito) = 105! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:11:18'!
add: anItem

	self add: anItem amount: 1! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 22:37:56'!
add: anItem amount: anAmount

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ].
	(anAmount isInteger and: [ anAmount > 0 ]) ifFalse: [ self error: self invalidAmountErrorMessage ].
	
	items at: anItem put: anAmount ! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:51:52'!
amountOf: anItem

	^ items at: anItem! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 23:47:08'!
initializeWith: aCatalog

	items := Dictionary new.
	catalog := aCatalog keys! !

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


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:33:15'!
cardExpiredErrorMessage

	^ 'La tarjeta de credito esta vencida'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:31:59'!
charge: aCreditCard for: aCarrito 
	
	(self isCreditCardExpired: aCreditCard) ifTrue: [ self error: self cardExpiredErrorMessage ].
	aCarrito isEmpty ifTrue: [ self error: self emptyCartErrorMessage ].
	
	^ aCarrito items inject: 0 into: [ :subtotal :nextItem | subtotal + ((aCarrito amountOf: nextItem) * (catalog at: nextItem)) ]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 22:24:28'!
emptyCartErrorMessage

	^ 'No puede hacerse checkout de un carrito vacío'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 23:00:55'!
initializeWith: aCatalog

	catalog := aCatalog! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:41:20'!
isCreditCardExpired: aCreditCard
	
	^ aCreditCard expirationDate end < Month current start! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 23:00:42'!
for: aCatalog

	^ self new initializeWith: aCatalog! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:32:57'!
expirationDate

	^ expirationDate copy! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:42:48'!
initializeWithExpiration: aMonth

	expirationDate := aMonth
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:41:40'!
expiration: aMonth

	^ self new initializeWithExpiration: aMonth
	
	! !
