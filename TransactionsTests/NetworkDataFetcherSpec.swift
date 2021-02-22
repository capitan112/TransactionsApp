//
//  NetworkDataFetcherSpec.swift
//  TransactionsTests
//
//  Created by Oleksiy Chebotarov on 13/02/2021.
//

import Quick
import Nimble
import Foundation
@testable import Transactions

class NetworkDataFetcherSpec: QuickSpec {
    override func spec() {
        
        describe("Network data fetcher") {
            var networkAPI: NetworkDataFetcher!
            let transactionsURL = "http://www.mocky.io/v2/5b36325b340000f60cf88903"
            
            context("fetch request with transaction by url") {
                beforeEach {
                    networkAPI = NetworkDataFetcher()
                }
                
                afterEach {
                    networkAPI = nil
                }
                
                it("should return not empty array") {
                    waitUntil { done in
                        
                        networkAPI.fetchTransactions(by: transactionsURL, completion: { response in
                            guard let dict = try? response.get(), let transactions = dict["data"] else {
                                fail()
                                return
                            }
                            expect(transactions.count).toNot(beNil())
                            expect(transactions.count).to(beGreaterThan(0))
                            expect(transactions.count).to(equal(10))
                        })
                        
                        done()
                    }
                }
            }
        }
    }
}
