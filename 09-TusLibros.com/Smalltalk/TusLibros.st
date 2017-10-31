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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 20:54:26'!
test02AlAgregarItemAlCarritoElCarritoNoEstaVacio

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	
	self deny: aCarrito isEmpty.
	self assert: aCarrito numberOfProducts = 1.
	self assert: (aCarrito amountOf: anItem) = 1.! !

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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 18:40:56'!
test06AlAgregarConsecutivamenteUnMismoProductoElCarritoGuardaLaCantidadCorrectaDelItem

	| aCatalog aCarrito anItem |
	
	anItem := 'yogurt'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	
	aCarrito add: anItem amount: 10.
	aCarrito add: anItem amount: 10.
	
	self assert: aCarrito numberOfProducts = 20.
	self assert: (aCarrito amountOf: anItem) = 20.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:09:57'!
test01NoEsPosibleHacerCheckoutDeCarritoVacio

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary new.
	aCarrito := Carrito for: aCatalog.
	aMPSimulator := MerchantProcessorSimulator new.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current next).
	aSalesBook := OrderedCollection new.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier emptyCartErrorMessage.
			self assert: (aSalesBook size) = 0.
			self deny: aMPSimulator processedPayment ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:11:29'!
test02CobroDeCarritoSolamenteConUnItemTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt'.
	aMPSimulator := MerchantProcessorSimulator new.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current next).
	aSalesBook := OrderedCollection new.
	
	self deny: aMPSimulator processedPayment.
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 15.
	self assert: aMPSimulator processedPayment.
	self assert: (aSalesBook size = 1).
	self assert: aSalesBook first = 15! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:11:41'!
test03CobroDeCarritoConDistintasUnidadesDeCadaItemTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aMPSimulator := MerchantProcessorSimulator new.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current next).
	aSalesBook := OrderedCollection new.
	
	self deny: aMPSimulator processedPayment.
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 105.
	self assert: aMPSimulator processedPayment.
	self assert: (aSalesBook size = 1).
	self assert: aSalesBook first = 105! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:11:51'!
test04HacerCheckoutDeUnCarritoConItemsConUnaTarjetaVencidaHaceUnMesDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aMPSimulator := MerchantProcessorSimulator new.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current previous).
	aSalesBook := OrderedCollection new.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier cardExpiredErrorMessage.
			self assert: aSalesBook size = 0.
			self deny: aMPSimulator processedPayment ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:12:05'!
test05HacerCheckoutDeUnCarritoConItemsConUnaTarjetaQueVenceEsteMesNoDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15. 'queso'. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt' amount: 5.
	aCarrito add: 'queso'.
	aMPSimulator := MerchantProcessorSimulator new.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current).
	aSalesBook := OrderedCollection new.
	
	self deny: aMPSimulator processedPayment.
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 105.
	self assert: aMPSimulator processedPayment.
	self assert: (aSalesBook size = 1).
	self assert: aSalesBook first = 105! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:12:13'!
test06HacerCheckoutDeUnCarritoConItemsConUnaTarjetaRobadaDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt'.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current).
	aSalesBook := OrderedCollection new.
	aMPSimulator := MerchantProcessorSimulator new.
	aMPSimulator markAsInvalid: aCreditCard description: 'La tarjeta fue robada'.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = 'La tarjeta fue robada'.
			self assert: aSalesBook size = 0.
			self deny: aMPSimulator processedPayment ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:12:21'!
test07HacerCheckoutDeUnCarritoConItemsConUnaTarjetaSinSaldoDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook aMPSimulator |
	
	aCatalog := Dictionary newFromPairs: {'yogurt'. 15}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: 'yogurt'.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current).
	aSalesBook := OrderedCollection new.
	aMPSimulator := MerchantProcessorSimulator new.
	aMPSimulator markAsInvalid: aCreditCard description: 'La tarjeta no tiene saldo suficiente'.
	aCashier := Cashier for: aCatalog with: aMPSimulator.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = 'La tarjeta no tiene saldo suficiente'.
			self assert: aSalesBook size = 0.
			self deny: aMPSimulator processedPayment ]! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/26/2017 21:11:18'!
add: anItem

	self add: anItem amount: 1! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 18:50:54'!
add: anItem amount: anAmount

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ].
	(anAmount isInteger and: [ anAmount > 0 ]) ifFalse: [ self error: self invalidAmountErrorMessage ].
	
	items at: anItem ifAbsent: [ items at: anItem put: 0 ].
	items at: anItem put: (items at: anItem) + anAmount! !

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

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 20:55:57'!
itemsDo: aBlock

	^ items keysDo: aBlock! !

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
	instanceVariableNames: 'catalog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/30/2017 00:33:15'!
cardExpiredErrorMessage

	^ 'La tarjeta de credito esta vencida'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:38:35'!
charge: aCreditCard for: aCarrito with: aSalesBook
	
	| aPurchaseTotal |
	
	(aCreditCard isCardExpiredAt: Month current) ifTrue: [ self error: self cardExpiredErrorMessage ].
	aCarrito isEmpty ifTrue: [ self error: self emptyCartErrorMessage ].
	
	aPurchaseTotal := 0.
	aCarrito itemsDo: [ :anItem | 
		aPurchaseTotal := aPurchaseTotal + ((aCarrito amountOf: anItem) * (catalog at: anItem)) ].
	
	merchantProcessor charge: aCreditCard for: aPurchaseTotal.
	
	aSalesBook add: aPurchaseTotal.
	
	^ aPurchaseTotal ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GJC 10/29/2017 22:24:28'!
emptyCartErrorMessage

	^ 'No puede hacerse checkout de un carrito vacío'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:36:42'!
initializeWith: aCatalog with: aMerchantProcessor

	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:36:16'!
for: aCatalog with: aMerchantProcessor

	^ self new initializeWith: aCatalog with: aMerchantProcessor ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:37:04'!
initializeWith: aCreditCardNumber with: aMonth
	
	number := aCreditCardNumber.
	expirationDate := aMonth
	
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 20:41:23'!
isCardExpiredAt: aMonth

	^ expirationDate end < aMonth start! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:35:43'!
number

	^ number copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:37:24'!
number: aCreditCardNumber expiration: aMonth

	^ self new initializeWith: aCreditCardNumber with: aMonth
	
	! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'invalidCards processedPayment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:01:33'!
charge: aCreditCard for: anAmount

	invalidCards at: (aCreditCard number) ifPresent: [ :desc | self error: desc ].
	self processPayment: aCreditCard for: anAmount.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:02:20'!
initialize

	invalidCards := Dictionary new.
	processedPayment := false! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'ST 10/30/2017 21:39:14'!
markAsInvalid: aCreditCard description: aString 
	
	invalidCards at: (aCreditCard number) put: aString! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:02:07'!
processPayment: aCreditCard for: anAmount

	processedPayment := true! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GJC 10/31/2017 14:03:03'!
processedPayment

	^ processedPayment ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
