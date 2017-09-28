!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'ST 9/25/2017 20:21:40'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ST 9/25/2017 20:21:46'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:28'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |
	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:06'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 3 = lines size.
	self assert: 'Deposito por 100' = (lines at: 1).
	self assert: 'Extraccion por 50' = (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GJC 9/28/2017 02:11:28'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portfolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GJC 9/28/2017 03:14:49'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortfolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 01:45:41'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^ AccountSummary of: aReceptiveAccount ! !

!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 02:01:41'!
accountTransferNetOf: aReceptiveAccount 
	
	^ TransferNet of: aReceptiveAccount ! !

!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 02:04:48'!
investmentEarningsOf: aReceptiveAccount 
	
	^ InvestmentEarnings of: aReceptiveAccount ! !

!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 02:05:05'!
investmentNetOf: aReceptiveAccount 
	
	^ InvestmentNet of: aReceptiveAccount ! !

!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 02:13:26'!
portfolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^ PortfolioTree of: aPortfolio withNames: aDictionary ! !

!PortfolioTest methodsFor: 'test support' stamp: 'GJC 9/28/2017 03:16:04'!
reversePortfolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^ ReversePortfolioTree of: aPortfolio withNames: aDictionary ! !


!classDefinition: #AccountOperation category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountOperation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 00:50:09'!
applyTo: anAccount

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountOperation class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation class
	instanceVariableNames: ''!

!AccountOperation class methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:28:27'!
of: anAccount

	^self new applyTo: anAccount! !


!classDefinition: #AccountBalance category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation subclass: #AccountBalance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 00:55:16'!
applyTo: anAccount

	^ anAccount transactions inject: 0 into: [ :net :transaction | transaction valueFor: (UpdateBalance with: net) ]! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:32:03'!
applyTo: anAccount

	^ anAccount transactions inject: (OrderedCollection new) into: [ :lines :nextTransaction | nextTransaction valueFor: (UpdateAccountSummary with: lines) ]! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation subclass: #InvestmentEarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:03:30'!
applyTo: anAccount

	^ anAccount transactions inject: 0 into: [ :earnings :transaction | transaction valueFor: (UpdateInvestmentEarnings with: earnings) ]! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation subclass: #InvestmentNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:04:06'!
applyTo: anAccount

	^ anAccount transactions inject: 0 into: [ :earnings :transaction | transaction valueFor: (UpdateInvestmentNet with: earnings) ]! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountOperation subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:04:22'!
applyTo: anAccount

	^ anAccount transactions inject: 0 into: [ :earnings :transaction | transaction valueFor: (UpdateTransferNet with: earnings) ]! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'GJC 9/26/2017 22:33:07'!
accountSummaryLine

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'GJC 9/26/2017 23:59:06'!
updateInvestmentNet: anAmount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'GJC 9/26/2017 23:35:54'!
updateTransferNet: anAmount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'GJC 9/28/2017 01:04:44'!
valueFor: aTransactionOperation

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'GJC 9/27/2017 00:13:54'!
updateInvestmentEarnings: anAmount
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 23:55:32'!
initializeFor: anAmount during: aNumberOfDays at: anInterest 
	
	value := anAmount.
	numberOfDays := aNumberOfDays.
	tna := anInterest! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:40:47'!
tna

	^tna! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:09:13'!
value

	^value! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:21:26'!
valueFor: aTransactionOperation

	^ aTransactionOperation applyToCertificateOfDeposit: self! !


!CertificateOfDeposit methodsFor: 'accessing' stamp: 'GJC 9/28/2017 01:48:02'!
numberOfDays
	
	^numberOfDays! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 23:56:27'!
register: anAmount during: aNumberOfDays at: anInterest on: anAccount

	anAccount register: (self new initializeFor: anAmount during: aNumberOfDays at: anInterest)! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'GJC 9/28/2017 01:05:49'!
valueFor: aTransactionOperation

	^ aTransactionOperation applyToDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #IncomingTransfer category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #IncomingTransfer
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:28:51'!
initializeFor: anAmount with: aTransfer

	value := anAmount.
	transfer := aTransfer! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:08:33'!
value

	^value! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:20:54'!
valueFor: aTransactionOperation

	^ aTransactionOperation applyToIncomingTransfer: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: #'PortfolioTreePrinter-Ejercicio'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:27:42'!
for: anAmount with: aTransfer

	^self new initializeFor: anAmount with: aTransfer! !

!IncomingTransfer class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:26:33'!
register: aValue on: anAccount with: aTransfer

	| incomingTransfer |
	
	incomingTransfer := self for: aValue with: aTransfer.
	anAccount register: incomingTransfer.

	^ incomingTransfer! !


!classDefinition: #OutgoingTransfer category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #OutgoingTransfer
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:28:58'!
initializeFor: anAmount with: aTransfer

	value := anAmount.
	transfer := aTransfer! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:08:53'!
value

	^value! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:21:03'!
valueFor: aTransactionOperation

	^ aTransactionOperation applyToOutgoingTransfer: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: #'PortfolioTreePrinter-Ejercicio'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:27:30'!
for: anAmount with: aTransfer

	^self new initializeFor: anAmount with: aTransfer! !

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:26:58'!
register: aValue on: anAccount with: aTransfer

	| outgoingTransfer |
	
	outgoingTransfer := self for: aValue with: aTransfer.
	anAccount register: outgoingTransfer.

	^ outgoingTransfer! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !

!Withdraw methodsFor: 'value' stamp: 'GJC 9/28/2017 01:21:17'!
valueFor: aTransactionOperation

	^ aTransactionOperation applyToWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #PortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PortfolioTree
	instanceVariableNames: 'indentLevel names'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:07:14'!
applyTo: aPortfolio withNames: aDictionary

	^ aPortfolio valueFor: (UpdatePortfolioTree withLines: (OrderedCollection new) names: aDictionary indentLevel: 0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:17:06'!
of: aPortfolio withNames: aDictionary

	^ self new applyTo: aPortfolio withNames: aDictionary ! !


!classDefinition: #ReversePortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #ReversePortfolioTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReversePortfolioTree methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:17:59'!
applyTo: aPortfolio withNames: aDictionary

	^ (PortfolioTree of: aPortfolio withNames: aDictionary) reverse ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReversePortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
ReversePortfolioTree class
	instanceVariableNames: ''!

!ReversePortfolioTree class methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:17:00'!
of: aPortfolio withNames: aDictionary

	^ self new applyTo: aPortfolio withNames: aDictionary ! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'GJC 9/28/2017 03:06:32'!
valueFor: anAccountOperation

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'GJC 9/28/2017 00:37:23'!
applyOperation: anOperation

	self subclassResponsibility! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'GJC 9/28/2017 01:24:50'!
balance

	^ AccountBalance of: self! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:22'!
manages: anAccount

	^ self = anAccount  or: [ accounts anySatisfy: [ :managedAccount | managedAccount manages: anAccount  ]  ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'GJC 9/28/2017 02:21:56'!
accounts

	^ accounts! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:23'!
transactions 

	^ accounts inject: OrderedCollection new into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'GJC 9/28/2017 03:05:38'!
valueFor: anAccountOperation

	^ anAccountOperation applyToPortfolio: self! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:48'!
with: anAccount1 with: anAccount2

	^ self withAll: (Array with: anAccount1 with: anAccount2 )! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:40'!
withAll: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size ifFalse: [ self error: self accountAlreadyManagedErrorMessage  ].
	
	aCollectionOfAccounts do: [ :sourceAccount | 
		aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ]]]].
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'GJC 9/28/2017 03:06:13'!
valueFor: anAccountOperation

	^ anAccountOperation applyToReceptiveAccount: self! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #TransactionOperation category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TransactionOperation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:09:39'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	self subclassResponsibility ! !

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:08:16'!
applyToDeposit: aDeposit

	self subclassResponsibility ! !

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:08:26'!
applyToIncomingTransfer: anIncomingTransfer

	self subclassResponsibility ! !

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:08:39'!
applyToOutgoingTransfer: anOutgoingTransfer

	self subclassResponsibility ! !

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:08:50'!
applyToWithdraw: aWithdraw

	self subclassResponsibility ! !

!TransactionOperation methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:07:48'!
initializeWith: aValue

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionOperation class' category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation class
	instanceVariableNames: ''!

!TransactionOperation class methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:07:29'!
with: aValue

	^self new initializeWith: aValue ! !


!classDefinition: #UpdateAccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation subclass: #UpdateAccountSummary
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:40:30'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	^ lines add: ('Plazo fijo por ', aCertificateOfDeposit value printString, ' durante ', aCertificateOfDeposit numberOfDays printString, ' dias a una tna de ', (aCertificateOfDeposit tna * 100) printString, '%') ; yourself.! !

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:46:39'!
applyToDeposit: aDeposit

	^ lines add: ('Deposito por ', aDeposit value printString) ; yourself! !

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:46:45'!
applyToIncomingTransfer: anIncomingTransfer

	^ lines add: ('Transferencia por ', anIncomingTransfer value printString) ; yourself! !

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:46:18'!
applyToOutgoingTransfer: anOutgoingTransfer

	^ lines add: ('Transferencia por ', anOutgoingTransfer value negated printString) ; yourself! !

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:46:52'!
applyToWithdraw: aWithdraw

	^ lines add: ('Extraccion por ', aWithdraw value printString) ; yourself! !

!UpdateAccountSummary methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:33:47'!
initializeWith: aCollection

	lines  := aCollection! !


!classDefinition: #UpdateBalance category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation subclass: #UpdateBalance
	instanceVariableNames: 'currentBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:09:58'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	^ currentBalance  - aCertificateOfDeposit value! !

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:06:43'!
applyToDeposit: aDeposit

	^ currentBalance + aDeposit value! !

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:07:12'!
applyToIncomingTransfer: anIncomingTransfer

	^ currentBalance + anIncomingTransfer value! !

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:07:30'!
applyToOutgoingTransfer: anOutgoingTransfer

	^ currentBalance - anOutgoingTransfer value! !

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:07:51'!
applyToWithdraw: aWithdraw

	^ currentBalance - aWithdraw value! !

!UpdateBalance methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:02:35'!
initializeWith: aCurrentBalance

	currentBalance  := aCurrentBalance ! !


!classDefinition: #UpdateInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation subclass: #UpdateInvestmentEarnings
	instanceVariableNames: 'currentEarnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:50:49'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	^ currentEarnings + (aCertificateOfDeposit value * (aCertificateOfDeposit tna / 360) * aCertificateOfDeposit numberOfDays)! !

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:51:35'!
applyToDeposit: aDeposit

	^ currentEarnings ! !

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:52:09'!
applyToIncomingTransfer: anIncomingTransfer

	^ currentEarnings ! !

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:52:23'!
applyToOutgoingTransfer: anOutgoingTransfer

	^ currentEarnings ! !

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:52:55'!
applyToWithdraw: aWithdraw

	^ currentEarnings ! !

!UpdateInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:53:26'!
initializeWith: aCurrentEarnings

	currentEarnings := aCurrentEarnings ! !


!classDefinition: #UpdateInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation subclass: #UpdateInvestmentNet
	instanceVariableNames: 'currentNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:58:38'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	^ currentNet + aCertificateOfDeposit value! !

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:57:15'!
applyToDeposit: aDeposit

	^ currentNet ! !

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:59:30'!
applyToIncomingTransfer: anIncomingTransfer

	^ currentNet ! !

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:59:50'!
applyToOutgoingTransfer: anOutgoingTransfer

	^ currentNet ! !

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:00:38'!
applyToWithdraw: aWithdraw

	^ currentNet ! !

!UpdateInvestmentNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:56:26'!
initializeWith: aCurrentInvestmentNet

	currentNet  := aCurrentInvestmentNet ! !


!classDefinition: #UpdateTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
TransactionOperation subclass: #UpdateTransferNet
	instanceVariableNames: 'currentNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:58:58'!
applyToCertificateOfDeposit: aCertificateOfDeposit

	^ currentNet ! !

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:57:21'!
applyToDeposit: aDeposit

	^ currentNet ! !

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:59:41'!
applyToIncomingTransfer: anIncomingTransfer

	^ currentNet + anIncomingTransfer value! !

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:00:03'!
applyToOutgoingTransfer: anOutgoingTransfer

	^ currentNet - anOutgoingTransfer value! !

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 02:00:51'!
applyToWithdraw: aWithdraw

	^ currentNet ! !

!UpdateTransferNet methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 01:56:40'!
initializeWith: aCurrentTransferNet

	currentNet  := aCurrentTransferNet ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value sourceAccount targetAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:30:39'!
initializeWithAmount: anAmount from: fromAccount to: toAccount

	value := anAmount .
	sourceAccount := fromAccount.
	targetAccount := toAccount.

	OutgoingTransfer register: value on: sourceAccount with: self.
	IncomingTransfer register: value on: targetAccount with: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'GJC 9/26/2017 22:31:01'!
register: anAmount from: fromAccount to: toAccount 
	
	self new initializeWithAmount: anAmount from: fromAccount to: toAccount! !


!classDefinition: #UpdatePortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #UpdatePortfolioTree
	instanceVariableNames: 'lines indentLevel names'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!UpdatePortfolioTree methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:13:14'!
applyToPortfolio: aPortfolio

	| portfolioLine |
	
	portfolioLine  := (String new: indentLevel withAll: $ ), (names at: aPortfolio).
	lines add: portfolioLine.
	^ aPortfolio accounts inject: lines into: [ :lines :nextAccount | nextAccount valueFor: (UpdatePortfolioTree withLines: lines names: names indentLevel: indentLevel + 1) ]! !

!UpdatePortfolioTree methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:13:30'!
applyToReceptiveAccount: aReceptiveAccount

	^ lines add: (String new: indentLevel withAll: $ ), (names at: aReceptiveAccount ) ; yourself! !

!UpdatePortfolioTree methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:02:34'!
initializeWithLines: aCollection names: aDictionary indentLevel: anInteger

	lines := aCollection.
	names := aDictionary.
	indentLevel := anInteger ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UpdatePortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
UpdatePortfolioTree class
	instanceVariableNames: ''!

!UpdatePortfolioTree class methodsFor: 'as yet unclassified' stamp: 'GJC 9/28/2017 03:02:56'!
withLines: aCollection names: aDictionary indentLevel: anInteger

	^ self new initializeWithLines: aCollection names: aDictionary indentLevel: anInteger ! !
