//
//  TransactionViewControllerTest.swift
//  TransactionsTests
//
//  Created by Oleksiy Chebotarov on 13/02/2021.
//

import XCTest
import SnapshotTesting
@testable import Transactions

class TransactionViewControllerTest: XCTestCase {
    
    
    func testTransactionsViewController() {
        let transactionsViewController = TransactionsViewController.instantiate(storyboardName: "Main")
        let viewModel = TransactionsViewModel()
        transactionsViewController.viewModel = viewModel
        viewModel.fetchTransactions()
        sleep(10)
        assertSnapshot(matching: transactionsViewController, as: .image(on: .iPhoneSe))
    }
}
