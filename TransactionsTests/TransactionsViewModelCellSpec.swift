//
//  TransactionsViewModelCellSpec.swift
//  TransactionsTests
//
//  Created by Oleksiy Chebotarov on 12/02/2021.
//
import Quick
import Nimble
import Foundation
@testable import Transactions

class TransactionsViewModelCellSpec: QuickSpec {
    override func spec() {
        var subject: MockTransactionViewModelCell!
        
        describe("The TransactionViewModelCell'") {
            context("Can should fetch data") {
                
                beforeEach {
                    subject = MockTransactionViewModelCell()
                }
                
                afterEach {
                    subject = nil
                }
                
                it("when it not fetched") {
                    expect(subject.isFetchTransactionsCalled).to(beFalse())
                }
                
                it("when it fetched") {
                    subject.fetchTransactions()
                    expect(subject.isFetchTransactionsCalled).to(beTrue())
                }
            }
        }
    }
}
