//
//  WarikanExampleTests.swift
//  WarikanExampleTests
//
//  Created by MURAKAMI on 2019/02/04.
//  Copyright © 2019 MURAKAMI. All rights reserved.
//

import XCTest
@testable import WarikanExample

class WarikanExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSucsessOrFailureCases() {
        let resSucsess = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resSucsess, SplitBillResult.sucsess(payment: Payment.init(payUnit: 100, amount: 1000, peopleNumber: 2)))
        
        
        // 支払い単位のバリデーション
        let resFailedPayUnitMin = SplitBillResult.splitBill(payUnit: 99, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resFailedPayUnitMin, SplitBillResult.failure(error: .payUnit))
        
        let resFailedPayUnitMax = SplitBillResult.splitBill(payUnit: 10001, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resFailedPayUnitMax, SplitBillResult.failure(error: .payUnit))
        
        let resSucsessPayUnitMax = SplitBillResult.splitBill(payUnit: 10000, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resSucsessPayUnitMax, SplitBillResult.sucsess(payment: Payment.init(payUnit: 10000, amount: 1000, peopleNumber: 2)))
        
        
        // 金額のバリデーション
        let resFailedAmountMin = SplitBillResult.splitBill(payUnit: 100, amount: 999, peopleNumber: 2)
        XCTAssertEqual(resFailedAmountMin, SplitBillResult.failure(error: .amount))
        
        let resFailedAmountMax = SplitBillResult.splitBill(payUnit: 100, amount: 100001, peopleNumber: 2)
        XCTAssertEqual(resFailedAmountMax, SplitBillResult.failure(error: .amount))
        
        let resSucsesAmountMax = SplitBillResult.splitBill(payUnit: 100, amount: 100000, peopleNumber: 2)
        XCTAssertEqual(resSucsesAmountMax, SplitBillResult.sucsess(payment: Payment.init(payUnit: 100, amount: 100000, peopleNumber: 2)))
        
        // 人数のバリデーション
        let resFailedPeopleMin = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 1)
        XCTAssertEqual(resFailedPeopleMin, SplitBillResult.failure(error: .peopleNumber))
        
        let resFailedPeopleMax = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 11)
        XCTAssertEqual(resFailedPeopleMax, SplitBillResult.failure(error: .peopleNumber))
        
        let resSucsesPeopleMax = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 10)
        XCTAssertEqual(resSucsesPeopleMax, SplitBillResult.sucsess(payment: Payment.init(payUnit: 100, amount: 1000, peopleNumber: 10)))
    }
    
    func testSplitBill() {
        let p1 = Payment.init(payUnit: 100, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(p1.payPerPerson, 500)
        XCTAssertEqual(p1.kickback, 0)
        
        let p2 = Payment.init(payUnit: 100, amount: 1000, peopleNumber: 3)
        XCTAssertEqual(p2.payPerPerson, 400)
        XCTAssertEqual(p2.kickback, 200)
        
        let p3 = Payment.init(payUnit: 100, amount: 1001, peopleNumber: 3)
        XCTAssertEqual(p3.payPerPerson, 400)
        XCTAssertEqual(p3.kickback, 199)
        
        let p4 = Payment.init(payUnit: 101, amount: 2020, peopleNumber: 10)
        XCTAssertEqual(p4.payPerPerson, 202)
        XCTAssertEqual(p4.kickback, 0)
    }
}
