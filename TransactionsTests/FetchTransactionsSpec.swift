//
//  FetchTransactionsSpec.swift
//  TransactionsTests
//
//  Created by Oleksiy Chebotarov on 13/02/2021.
//

import Quick
import Nimble
import Foundation
@testable import Transactions

class FetchTransactionsSpec: QuickSpec {
    override func spec() {
        var subject: TransactionsViewModelType!
        describe("fetch transactions in ViewModel") {
            context("should get real transactions") {
                beforeEach {
                    subject = TransactionsViewModel()
                }
                
                afterEach {
                    subject = nil
                }
                
                it("first transaction properties should be equal") {
                    subject.fetchTransactions()
                    expect(subject.transactions.value?.first?.id).toEventually(equal("13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28"))
                    expect(subject.transactions.value?.first?.category).toEventually(equal("General"))
                    expect(subject.transactions.value?.first?.price).toEventually(equal(13.0))
                    expect(subject.transactions.value?.first?.currencyISO).toEventually(equal("GBP"))
                }
            }
        }
    }
}
