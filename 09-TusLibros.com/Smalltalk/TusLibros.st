!classDefinition: #CarritoTest category: #TusLibros!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:37:13'!
test01AlCrearUnCarritoElCarritoEstaVacio

	| aCarrito |
	aCarrito := StoreTestObjectsFactory emptyCart.
	
	self assert: aCarrito isEmpty.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:38:15'!
test02AlAgregarItemAlCarritoElCarritoNoEstaVacio

	| aCatalog aCarrito anItem |
	
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	
	self deny: aCarrito isEmpty.
	self assert: aCarrito numberOfProducts = 1.
	self assert: (aCarrito amountOf: anItem) = 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:39:23'!
test03ElCarritoNoPermiteAgregarItemsInvalidos

	| aCarrito anItem |
	aCarrito := StoreTestObjectsFactory emptyCart.
	anItem := '123'.

	self should: [ aCarrito add: anItem ] raise: Error - MessageNotUnderstood withExceptionDo: [ :anError |
		self assert: anError messageText = aCarrito invalidItemErrorMessage.
		self assert: aCarrito isEmpty ].! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:51:57'!
test04ElCarritoSoloPermiteAgregarCantidadesEnterasYPositivas

	| aCatalog aCarrito anItem |
	
	anItem := '123'.
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:52:15'!
test05ElCarritoGuardaLaCantidadCorrectaDeCadaItem

	| aCatalog aCarrito anItem anotherItem |
	
	anItem := '123'.
	anotherItem := '456'.
	aCatalog := Dictionary newFromPairs: {anItem. 10. anotherItem. 15.}.
	aCarrito := Carrito for: aCatalog.
	
	aCarrito add: anItem amount: 10.
	aCarrito add: anotherItem.
	
	self assert: aCarrito numberOfProducts = 11.
	self assert: (aCarrito amountOf: anItem) = 10.
	self assert: (aCarrito amountOf: anotherItem) = 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:52:26'!
test06AlAgregarConsecutivamenteUnMismoProductoElCarritoGuardaLaCantidadCorrectaDelItem

	| aCatalog aCarrito anItem |
	
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	aCarrito := Carrito for: aCatalog.
	
	aCarrito add: anItem amount: 10.
	aCarrito add: anItem amount: 10.
	
	self assert: aCarrito numberOfProducts = 20.
	self assert: (aCarrito amountOf: anItem) = 20.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'merchantProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:38:06'!
charge: aCreditCard for: anAmount

	merchantProcessorSimulator value: aCreditCard value: anAmount ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:16:47'!
test01NoEsPosibleHacerCheckoutDeCarritoVacio

	| aCatalog aCarrito aCashier aCreditCard aSalesBook |
	
	aCatalog := Dictionary new.
	aCarrito := Carrito for: aCatalog.
	merchantProcessorSimulator := [ :card :amount | self fail ].
	aCashier := Cashier for: aCatalog with: self.
	aCreditCard := StoreTestObjectsFactory creditCard.
	aSalesBook := SaleBook new.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier emptyCartErrorMessage.
			self assert: (aSalesBook size) = 0 ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:32:48'!
test02CobroDeCarritoSolamenteConUnItemTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard aSalesBook actualChargedAmount anItem |
	
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 15.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	merchantProcessorSimulator := [ :card :amount |
		actualChargedAmount := amount].
	aCashier := Cashier for: aCatalog with: self.
	aCreditCard := StoreTestObjectsFactory creditCard.
	aSalesBook := SaleBook new.
	
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 15.
	self assert: (aSalesBook total) = 15.
	self assert: actualChargedAmount = 15.
	self assert: (aSalesBook size = 1).
	self assert: (aSalesBook items at: anItem) = 1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:33:01'!
test03CobroDeCarritoConDistintasUnidadesDeCadaItemTieneTotalCorrecto

	| aCatalog aCarrito aCashier aCreditCard aSalesBook actualChargedAmount anItem anotherItem |
	
	anItem := '123'.
	anotherItem := '456'.
	aCatalog := Dictionary newFromPairs: {anItem. 15. anotherItem. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem amount: 5.
	aCarrito add: anotherItem.
	merchantProcessorSimulator := [ :card :amount |
		actualChargedAmount := amount].
	aCashier := Cashier for: aCatalog with: self.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current next) ownerName: 'Pepe'.
	aSalesBook := SaleBook new.
	
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 105.
	self assert: (aSalesBook total) = 105.
	self assert: actualChargedAmount = 105.
	self assert: (aSalesBook size = 2).
	self assert: (aSalesBook items at: anItem) = 5.
	self assert: (aSalesBook items at: anotherItem) = 1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:29:21'!
test04HacerCheckoutDeUnCarritoConItemsConUnaTarjetaVencidaHaceUnMesDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook anItem anotherItem |
	
	anItem := '123'.
	anotherItem = '456'.
	aCatalog := Dictionary newFromPairs: {anItem. 15. anotherItem. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem amount: 5.
	aCarrito add: anotherItem.
	merchantProcessorSimulator := [ :card :amount | self fail ].
	aCashier := Cashier for: aCatalog with: self.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current previous) ownerName: 'Pepe'.
	aSalesBook := SaleBook new.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = aCashier cardExpiredErrorMessage.
			self assert: aSalesBook size = 0 ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:33:12'!
test05HacerCheckoutDeUnCarritoConItemsConUnaTarjetaQueVenceEsteMesNoDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook actualChargedAmount anItem anotherItem |
	
	anItem := '123'.
	anotherItem := '456'.
	aCatalog := Dictionary newFromPairs: {anItem. 15. anotherItem. 30.}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem amount: 5.
	aCarrito add: anotherItem.
	merchantProcessorSimulator := [ :card :amount |
		actualChargedAmount := amount].
	aCashier := Cashier for: aCatalog with: self.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current) ownerName: 'Pepe'.
	aSalesBook := SaleBook new.
	
	self assert: (aCashier charge: aCreditCard for: aCarrito with: aSalesBook) = 105.
	self assert: (aSalesBook total) = 105.
	self assert: actualChargedAmount = 105.
	self assert: (aSalesBook size = 2).
	self assert: (aSalesBook items at: anItem) = 5.
	self assert: (aSalesBook items at: anotherItem) = 1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:29:13'!
test06HacerCheckoutDeUnCarritoConItemsConUnaTarjetaRobadaDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook anErrorMessage anItem |
	
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 15}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current) ownerName: 'Pepe'.
	aSalesBook := SaleBook new.
	anErrorMessage := 'La tarjeta fue robada'.
	merchantProcessorSimulator := [ :card :amount | self error: anErrorMessage ].
	aCashier := Cashier for: aCatalog with: self.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anErrorMessage.
			self assert: aSalesBook size = 0 ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:29:56'!
test07HacerCheckoutDeUnCarritoConItemsConUnaTarjetaSinSaldoDebeFallar

	| aCatalog aCarrito aCashier aCreditCard aSalesBook anErrorMessage anItem |
	
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 15}.
	aCarrito := Carrito for: aCatalog.
	aCarrito add: anItem.
	aCreditCard := CreditCard number: '0123456789101112' expiration: (Month current) ownerName: 'Pepe'.
	aSalesBook := SaleBook new.
	anErrorMessage := 'La tarjeta no tiene saldo suficiente'.
	merchantProcessorSimulator := [ :card :amount | self error: anErrorMessage ].
	aCashier := Cashier for: aCatalog with: self.
	
	self 
		should: [ aCashier charge: aCreditCard for: aCarrito with: aSalesBook ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anErrorMessage.
			self assert: aSalesBook size = 0 ]! !


!classDefinition: #InterfaceTest category: #TusLibros!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'merchantProcessorSimulator timeDelegateBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:04:56'!
charge: aCreditCard for: anAmount

	merchantProcessorSimulator value: aCreditCard value: anAmount ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:26:28'!
now

	^ timeDelegateBlock value! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:56:36'!
test01CrearCarritoConUsuarioInvalidoFalla

	| aClientId aClientIdPassword anInterface anAuthenticationService aCashier aCatalog |
	
	anAuthenticationService := Dictionary new.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := Dictionary new.
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	
	self
		should: [ anInterface createCartFor: aClientId with: aClientIdPassword ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidClientIdErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:56:32'!
test02CrearCarritoConPasswordInvalidaFalla

	| aClientId anInterface anAuthenticationService aCorrectClientIdPassword aWrongClientIdPassword aCashier aCatalog |
	
	aClientId := '1234'.
	aCorrectClientIdPassword := 'pass'.
	aWrongClientIdPassword := 'wrongpass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aCorrectClientIdPassword.}.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := Dictionary new.
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface createCartFor: aClientId with: aWrongClientIdPassword ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface wrongPasswordErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:56:26'!
test03CrearCarritoConDatosValidosEsExitoso

	| aClientId anInterface anAuthenticationService aClientIdPassword cartId aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := Dictionary new.
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	
	self assert: (anInterface listCart: cartId) isEmpty! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:56:08'!
test04AgregarItemACarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface add: aBookISBN quantity: 10 to: 123 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidCartErrorMessage ].! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:57:18'!
test05AgregarItemACarritoValidoActualizaLosItemsDelCarrito

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice cartId aBookQuantity cartList aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	aBookQuantity := 10.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	cartList := anInterface listCart: cartId.
	
	self assert: (cartList size) = 1.
	self assert: (cartList at: aBookISBN) = aBookQuantity! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:57:37'!
test06ListCartDeCarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface listCart: 123 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: (anException messageText) = anInterface invalidCartErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:57:49'!
test07CheckoutDeCarritoInvalidoFalla

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.
	aBookISBN := '12345'.
	aBookPrice := 15.
	timeDelegateBlock := [ DateAndTime now ].
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	aCashier := Cashier for: aCatalog with: self.
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface checkOut: 123 with: '1234567890101112' with: (Month current) with: 'Pepe' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidCartErrorMessage.
			]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:36:32'!
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
	
	timeDelegateBlock := [ DateAndTime now ].
	
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	
	transactionId := anInterface checkOut: cartId with: '1234567890101112' with: (Month current) with: 'Pepe'.
	
	self assert: actualChargedAmount = aTotal.
	self deny: transactionId = nil! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:59:02'!
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
	timeDelegateBlock := [ DateAndTime now ].
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface listPurchasesOf: aWrongClientId with: aClientIdPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface invalidClientIdErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:59:09'!
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
	timeDelegateBlock := [ DateAndTime now ].
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	
	self
		should: [ anInterface listPurchasesOf: aClientId with: aWrongClientIdPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText = anInterface wrongPasswordErrorMessage ]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:31:56'!
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
	timeDelegateBlock := [ DateAndTime now ].
	
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	anInterface add: aBookISBN quantity: aBookQuantity to: cartId.
	anInterface add: anotherBookISBN quantity: anotherBookQuantity to: cartId.	
	anInterface checkOut: cartId with: '1234567890101112' with: (Month current) with: 'Pepe'.
	
	aSalesHistory := anInterface listPurchasesOf: aClientId with: aClientIdPassword.
	
	self assert: (aSalesHistory items at: aBookISBN) = aBookQuantity.
	self assert: (aSalesHistory items at: anotherBookISBN) = anotherBookQuantity.
	self assert: (aSalesHistory size) = 2.
	self assert: (aSalesHistory total) = 400! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:27:26'!
test12CarritoDebeExpirarDespuesDe30MinutosDeInactividad

	| aClientId anInterface anAuthenticationService aClientIdPassword aBookISBN aBookPrice aBookQuantity cartId aCashier aCatalog |
	
	aClientId := '1234'.
	aClientIdPassword := 'pass'.
	anAuthenticationService := Dictionary newFromPairs: {aClientId. aClientIdPassword.}.

	aBookISBN := '12345'.
	aBookPrice := 15.
	aBookQuantity := 10.
	aCatalog := (Dictionary newFromPairs: {aBookISBN. aBookPrice.}).
	merchantProcessorSimulator := [ :aCreditCard :anAmount | ].
	aCashier := Cashier for: aCatalog with: self.
	
	timeDelegateBlock := [ DateAndTime now ].
	anInterface := Interface newWith: anAuthenticationService with: aCatalog with: aCashier with: self.
	cartId := anInterface createCartFor: aClientId with: aClientIdPassword.
	
	timeDelegateBlock := [ DateAndTime now + (Duration minutes: 30) ].
	
	self
		should: [ anInterface add: aBookISBN quantity: aBookQuantity to: cartId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText = (anInterface cartExpiredErrorMessage).
			timeDelegateBlock := [ DateAndTime now ].
			self assert: (anInterface listCart: cartId) isEmpty ]! !


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

!Carrito methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:31:09'!
amountOf: anItem
	
	^ items at: anItem ifAbsent: [ 0 ]! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:24:05'!
charge: aCreditCard for: aCarrito with: aSalesBook
	
	| aPurchaseTotal updatedSalesBook |
	
	(aCreditCard isCardExpiredAt: Month current) ifTrue: [ self error: self cardExpiredErrorMessage ].
	aCarrito isEmpty ifTrue: [ self error: self emptyCartErrorMessage ].
	
	aPurchaseTotal := 0.
	updatedSalesBook := Dictionary new.
	aCarrito itemsDo: [ :anItem | 
		aPurchaseTotal := aPurchaseTotal + ((aCarrito amountOf: anItem) * (catalog at: anItem)).
		updatedSalesBook at: anItem put: (((aSalesBook items) at: anItem ifAbsent: [ 0 ]) + (aCarrito amountOf: anItem)) ].
	
	merchantProcessor charge: aCreditCard for: aPurchaseTotal.
	aSalesBook updateWithItems: updatedSalesBook with: aPurchaseTotal.
	
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

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:21:59'!
number: aCreditCardNumber expiration: aMonth ownerName: aName

	"Borrar mensaje"

	^ self new initializeWith: aCreditCardNumber with: aMonth with: aName
	
	! !


!classDefinition: #Interface category: #TusLibros!
Object subclass: #Interface
	instanceVariableNames: 'authenticationService carts cartCatalog cashier lastCartId lastTransactionId salesBooks timeDelegate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:23:47'!
add: aBookISBN quantity: anInteger to: aCartId

	|  aCart aCartRegistry |
	aCartRegistry := self getCartRegistryFor: aCartId.
	aCart := aCartRegistry at: 1.
	
	aCart add: aBookISBN amount: anInteger! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:22:21'!
cartExpiredErrorMessage

	^ 'El carrito ha expirado'! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:30:27'!
checkOut: aCartId with: aCreditCardNumber with: anExpirationDate with: aCreditCardOwner

	| aCart aCreditCard aCartRegistry aClientId aSalesBook |
	aCartRegistry := self getCartRegistryFor: aCartId.
	aCart := aCartRegistry at: 1.
	aClientId := aCartRegistry at: 2.
	
	aCreditCard := CreditCard number: aCreditCardNumber expiration: anExpirationDate ownerName: aCreditCardOwner.
	aSalesBook := salesBooks at: aClientId ifAbsentPut: [ SaleBook new ].
	cashier charge: aCreditCard for: aCart with: aSalesBook.
	
	^ self createTransactionId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:21:58'!
checkValidCart: aCartRegistry
	
	| lastUsed |
	
	lastUsed := aCartRegistry at: 3.
	((lastUsed + (Duration minutes: 30)) < (timeDelegate now)) ifTrue: [ self error: self cartExpiredErrorMessage ]! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:18:01'!
createCartFor: aClientId with: aClientIdPassword
	
	| password cartId |
	
	password := authenticationService at: aClientId ifAbsent: [ self error: self invalidClientIdErrorMessage ].
	(password = aClientIdPassword) ifFalse: [ self error: self wrongPasswordErrorMessage ].
	
	cartId := self createCartId.
	carts at: cartId put: {(Carrito for: cartCatalog). aClientId. timeDelegate now.}.
	^ cartId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:13:59'!
createCartId
	
	lastCartId := lastCartId + 1.
	^ lastCartId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:14:29'!
createTransactionId

	lastTransactionId := lastTransactionId + 1.
	^ lastTransactionId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:19:30'!
getCartRegistryFor: aCartId

	| aCartRegistry |
	
	aCartRegistry := carts at: aCartId ifAbsent: [ self error: self invalidCartErrorMessage ].
	self checkValidCart: aCartRegistry.
	self updateCartRegistryLastUsedTime: aCartRegistry.
	^ aCartRegistry ! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:07:54'!
initializeWith: anAuthenticationService with: aCatalog with: aCashier with: aTimeDelegate

	lastCartId := 0.
	lastTransactionId := 0.
	carts := Dictionary new.
	authenticationService := anAuthenticationService.
	cartCatalog := aCatalog.
	cashier := aCashier.
	salesBooks := Dictionary new.
	timeDelegate := aTimeDelegate! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 21:07:22'!
invalidCartErrorMessage
	
	^ 'El ID de carrito no existe'! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 19:58:13'!
invalidClientIdErrorMessage
	
	^ 'El ID de cliente no existe'! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:24:43'!
listCart: aCartId 
	
	| aCart aCartRegistry |
	aCartRegistry := self getCartRegistryFor: aCartId.
	aCart := aCartRegistry at: 1.
	^ aCart itemsAndQuantities! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 20:50:05'!
listPurchasesOf: aClientId with: aClientIdPassword

	| password |
	
	password := authenticationService at: aClientId ifAbsent: [ self error: self invalidClientIdErrorMessage ].
	(password = aClientIdPassword) ifFalse: [ self error: self wrongPasswordErrorMessage ].
	
	^ salesBooks at: aClientId! !

!Interface methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:23:03'!
updateCartRegistryLastUsedTime: aCartRegistry

	aCartRegistry atWrap: 3 put: timeDelegate now! !

!Interface methodsFor: 'as yet unclassified' stamp: 'ST 11/2/2017 20:06:27'!
wrongPasswordErrorMessage

	^ 'Contraseña invalida'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: #TusLibros!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'GJC 11/5/2017 23:07:37'!
newWith: anAuthenticationService with: aCatalog with: aCashier with: aTimeDelegate 

	^ self new initializeWith: anAuthenticationService with: aCatalog with: aCashier with: aTimeDelegate! !


!classDefinition: #SaleBook category: #TusLibros!
Object subclass: #SaleBook
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleBook methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:14:36'!
initialize

	items := Dictionary new.
	total := 0! !

!SaleBook methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:24:30'!
items

	^ items! !

!SaleBook methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:17:14'!
size

	^ items size! !

!SaleBook methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:32:04'!
total

	^ total! !

!SaleBook methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 17:15:16'!
updateWithItems: aDictionary with: aTotal

	items addAll: aDictionary.
	total := aTotal! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreTestObjectsFactory class' category: #TusLibros!
StoreTestObjectsFactory class
	instanceVariableNames: ''!

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:54:49'!
creditCard

	^ CreditCard number: '0123456789101112' expiration: (Month current next) ownerName: 'Pepe'! !

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:36:17'!
emptyCart

	^ Carrito for: (self emptyCatalog)! !

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:35:23'!
emptyCatalog

	^ Dictionary new! !

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:41:16'!
singleItemCatalog

	| anItem |
	anItem := '123'.
	^ Dictionary newFromPairs: {anItem. 10.}! !

!StoreTestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'ST 11/6/2017 16:41:47'!
singleItemCatalogCart

	| anItem aCatalog |
	anItem := '123'.
	aCatalog := Dictionary newFromPairs: {anItem. 10.}.
	^ Carrito for: aCatalog.! !
