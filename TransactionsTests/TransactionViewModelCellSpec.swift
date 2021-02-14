//
//  TransactionViewModelCellSpec.swift
//  TransactionsTests
//
//  Created by Oleksiy Chebotarov on 12/02/2021.
//

import Quick
import Nimble
import Foundation
@testable import Transactions

class TransactionViewModelCellSpec: QuickSpec {
    override func spec() {
        describe("Check fetch data in TransactionViewModelCell ") {
            var subject: TransactionViewModelCell!
            var transaction: Transaction!
            
            context("from GBP transaction") {
                beforeEach {
                    do {
                        let jsonData = transactionsGBPjson.data(using: .utf8)!
                        transaction = try JSONDecoder().decode(Transaction.self, from: jsonData)
                    } catch {
                        fail("Problem parsing GBP JSON")
                    }
                    
                    subject = TransactionViewModelCell(transaction: transaction)
                }
                
                afterEach {
                    transaction = nil
                    subject = nil
                }
            
                it("check tranaction price") {
                    expect(transaction.price).to(equal(Double(13.00)))
                }
                
                it("check tranaction currence ISO") {
                    expect(transaction.currencyISO).to(equal("GBP"))
                }
                
                it("cell price should be formatted") {
                    print(subject.price)
                    expect(subject.price).to(equal("£13.00"))
                }
            }
            
            context("from EUR transaction") {
                beforeEach {
                    do {
                        let jsonData = transactionsEURjson.data(using: .utf8)!
                        transaction = try JSONDecoder().decode(Transaction.self, from: jsonData)
                    } catch {
                        fail("Problem parsing EUR JSON")
                    }
                    
                    subject = TransactionViewModelCell(transaction: transaction)
                }
                
                afterEach {
                    transaction = nil
                    subject = nil
                }
            
                it("check tranaction price") {
                    expect(transaction.price).to(equal(Double(15.00)))
                }
                
                it("check tranaction currence ISO") {
                    expect(transaction.currencyISO).to(equal("EUR"))
                }
                
                it("cell price should be formatted") {
                    print(subject.price)
                    expect(subject.price).to(equal("€15.00"))
                }
            }
        }
    }
}



