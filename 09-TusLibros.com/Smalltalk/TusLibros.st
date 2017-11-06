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


!classDefinition: #InterfaceTest category: #TusLibros!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'merchantProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:04:56'!
charge: aCreditCard for: anAmount

	merchantProcessorSimulator value: aCreditCard value: anAmount ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:47:08'!
test01CrearCarritoConUsuarioInvalidoFalla

	| aClientId aClientIdPassword anInterface anAuthenticationService |
	
	anAuthenticationService := Dictionary new.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {}).
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	
	self
		should: [ anInterface createCartFor: aClientId with: aClientIdPassword ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidClientIdErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:47:01'!
test02CrearCarritoConPasswordInvalidaFalla

	| aClientId anInterface anAuthenticationService aCorrectClientIdPassword aWrongClientIdPassword |
	
	aClientId := '1234'.
	aCorrectClientIdPassword := 'pass'.
	aWrongClientIdPassword := 'wrongpass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aCorrectClientIdPassword.}.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {}).
	
	self
		should: [ anInterface createCartFor: aClientId with: aWrongClientIdPassword ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface wrongPasswordErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:46:56'!
test03CrearCarritoConDatosValidosEsExitoso

	| aClientId anInterface anAuthenticationService aClientIdPassword cartId |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {}).
	
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	
	self assert: (anInterface listCart: cartId) isEmpty! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 21:10:35'!
test04AgregarItemACarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	
	self
		should: [ anInterface add: aBookISBN quantity: 10 to: 123 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidCartErrorMessage ].! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/4/2017 19:02:56'!
test05AgregarItemACarritoValidoActualizaLosItemsDelCarrito

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice cartId aBookQuantity cartList |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	aBookQuantity := 10.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	cartList := anInterface listCart: cartId.
	
	self assert: (cartList size) = 1.
	self assert: (cartList at: aBookISBN) = aBookQuantity! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/4/2017 19:22:01'!
test06ListCartDeCarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	
	self
		should: [ anInterface listCart: 123 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: (anException messageText) = anInterface invalidCartErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/4/2017 19:16:28'!
test07CheckoutDeCarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	anInterface := Interface newWith: anAuthenticationService with: (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	
	self
		should: [ anInterface checkOut: 123 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidCartErrorMessage.
			]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:19:41'!
test08CheckoutDeCarritoValidoProcesaMontoCorrecto

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aBookQuantity cartId transactionId aCashier aCatalog aTotal actualChargedAmount |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.

	aBookISBN := '12345'.
	aBookPrice := 15.
	aBookQuantity := 10.
	aTotal := aBookPrice * aBookQuantity.
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	
	merchantProcessorSimulator := [ :aCreditCard :anAmount |
		actualChargedAmount := anAmount].
	aCashier := Cashier for: aCatalog with: self.
	
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier.
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	
	transactionId := anInterface checkOut: cartId with: '1234567890101112' with: (Month current) with: 'Pepe'.
	
	self assert: actualChargedAmount = aTotal.
	self deny: transactionId = nil! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:32:47'!
test09ListPurchasesDeClienteInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aCashier aCatalog aWrongClientId |
	
	aClientId := '1234'.
	aWrongClientId := '123'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.

	aBookISBN := '12345'.
	aBookPrice := 15.
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier.
	
	self
		should: [ anInterface listPurchasesOf: aWrongClientId with: aClientIdPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidClientIdErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:34:25'!
test10ListPurchasesConPasswordInvalidaFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aCashier aCatalog aWrongClientIdPassword |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	aWrongClientIdPassword := 'wrongpass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.

	aBookISBN := '12345'.
	aBookPrice := 15.
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier.
	
	self
		should: [ anInterface listPurchasesOf: aClientId with: aWrongClientIdPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface wrongPasswordErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:46:07'!
test11ListPurchasesListaLasComprasCorrectamente

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aBookQuantity cartId aCashier aCatalog aSalesHistory anotherBookISBN anotherBookPrice anotherBookQuantity |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.

	aBookISBN := '12345'.
	aBookPrice := 15.
	aBookQuantity := 10.
	anotherBookISBN := '6789'.
	anotherBookPrice := 50.
	anotherBookQuantity := 5.
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice. anotherBookISBN. anotherBookPrice.}).
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCashier := Cashier for: aCatalog with: self.
	
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier.
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	anInterface add: anotherBookISBN quantity: anotherBookQuantity to: cartId.	
	anInterface checkOut: cartId with: '1234567890101112' with: (Month current) with: 'Pepe'.
	
	aSalesHistory := anInterface listPurchasesOf: aClientId with: aClientIdPassword.
	
	self assert: (aSalesHistory at: aBookISBN) = aBookQuantity.
	self assert: (aSalesHistory at: anotherBookISBN) = anotherBookQuantity.
	self assert: (aSalesHistory size) = 2! !


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

!Carrito methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 21:01:45'!
amountOf: anItem
	"Pensar si habria que fallar o devolver 0 cuando el item no esta en el carrito"
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

!Carrito methodsFor: 'as yet unclassified' stamp: 'GJC 11/4/2017 18:55:34'!
itemsAndQuantities

	^ items copy! !

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
	instanceVariableNames: 'expirationDate number ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:21:21'!
initializeWith: aCreditCardNumber with: aMonth
	
	"Borrar este mensaje"
	
	number := aCreditCardNumber.
	expirationDate := aMonth
	
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:21:06'!
initializeWith: aCreditCardNumber with: aMonth with: anOwnerName
	
	number := aCreditCardNumber.
	expirationDate := aMonth.
	ownerName := anOwnerName! !

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

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:21:59'!
number: aCreditCardNumber expiration: aMonth ownerName: aName

	"Borrar mensaje"

	^ self new initializeWith: aCreditCardNumber with: aMonth with: aName
	
	! !


!classDefinition: #Interface category: #TusLibros!
Object subclass: #Interface
	instanceVariableNames: 'authenticationService carts cartCatalog cashier lastCartId lastTransactionId salesBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 21:00:35'!
add: aBookISBN quantity: anInteger to: aCartId

	|  aCart aCartRegistry |
	aCartRegistry := carts at: aCartId ifAbsent: [ self error: self invalidCartErrorMessage ].
	aCart := aCartRegistry at: 1.
	
	aCart add: aBookISBN amount: anInteger! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:58:54'!
checkOut: aCartId with: aCreditCardNumber with: anExpirationDate with: aCreditCardOwner

	| aCart aCreditCard aCartRegistry aClientId aSalesBook |
	aCartRegistry := carts at: aCartId ifAbsent: [ self error: self invalidCartErrorMessage ].
	aCart := aCartRegistry at: 1.
	aClientId := aCartRegistry at: 2.
	
	aCreditCard := CreditCard number: aCreditCardNumber expiration: anExpirationDate ownerName: aCreditCardOwner.
	aSalesBook := salesBooks at: aClientId ifAbsentPut: [ OrderedCollection new ].
	cashier charge: aCreditCard for: aCart with: aSalesBook.
	
	^ self createTransactionId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:59:47'!
createCartFor: aClientId with: aClientIdPassword
	
	| password cartId |
	
	password := authenticationService at: aClientId ifAbsent: [ self error: self invalidClientIdErrorMessage ].
	(password = aClientIdPassword) ifFalse: [ self error: self wrongPasswordErrorMessage ].
	
	cartId := self createCartId.
	carts at: cartId put: {(Carrito for: cartCatalog). aClientId.}.
	^ cartId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:13:59'!
createCartId
	
	lastCartId := lastCartId + 1.
	^ lastCartId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:14:29'!
createTransactionId

	lastTransactionId := lastTransactionId + 1.
	^ lastTransactionId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:16:47'!
initializeWith: anAuthenticationService with: aCatalog
	
	"Borrar este mensaje"
	
	lastCartId := 0.
	lastTransactionId := 0.
	carts := Dictionary new.
	authenticationService := anAuthenticationService.
	cartCatalog := aCatalog ! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:51:39'!
initializeWith: anAuthenticationService with: aCatalog with: aCashier

	lastCartId := 0.
	lastTransactionId := 0.
	carts := Dictionary new.
	authenticationService := anAuthenticationService.
	cartCatalog := aCatalog.
	cashier := aCashier.
	salesBooks := Dictionary new! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 21:07:22'!
invalidCartErrorMessage
	
	^ 'El ID de carrito no existe'! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 19:58:13'!
invalidClientIdErrorMessage
	
	^ 'El ID de cliente no existe'! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/4/2017 19:20:57'!
listCart: aCartId 
	
	^ (carts at: aCartId ifAbsent: [ self error: self invalidCartErrorMessage ]) itemsAndQuantities! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:50:05'!
listPurchasesOf: aClientId with: aClientIdPassword

	| password |
	
	password := authenticationService at: aClientId ifAbsent: [ self error: self invalidClientIdErrorMessage ].
	(password = aClientIdPassword) ifFalse: [ self error: self wrongPasswordErrorMessage ].
	
	^ salesBooks at: aClientId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:06:27'!
wrongPasswordErrorMessage

	^ 'Contraseña invalida'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: #TusLibros!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:45:11'!
newWith: anAuthenticationService with: aCatalog

	^ self new initializeWith: anAuthenticationService with: aCatalog ! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:05:36'!
newWith: anAuthenticationService with: aCatalog with: aCashier

	^ self new initializeWith: anAuthenticationService with: aCatalog with: aCashier! !


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
