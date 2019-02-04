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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        
        let res = SplitBillResult.failure(message: "失敗")
        XCTAssertEqual(res, SplitBillResult.failure(message: "失敗"))
        
        let resSucsess = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resSucsess, SplitBillResult.sucsess(payment: Payment.init(payPerPerson: 100, kickback: 100)))
        
        
        // 支払い単位のバリデーション
        let resFailedPayUnitMin = SplitBillResult.splitBill(payUnit: 99, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resFailedPayUnitMin, SplitBillResult.failure(message: "支払単位が範囲外です"))
        
        let resFailedPayUnitMax = SplitBillResult.splitBill(payUnit: 10001, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resFailedPayUnitMax, SplitBillResult.failure(message: "支払単位が範囲外です"))
        
        let resSucsessPayUnitMax = SplitBillResult.splitBill(payUnit: 10000, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(resSucsessPayUnitMax, SplitBillResult.sucsess(payment: Payment.init(payPerPerson: 100, kickback: 100)))
        
        
        // 金額のバリデーション
        let resFailedAmountMin = SplitBillResult.splitBill(payUnit: 100, amount: 999, peopleNumber: 2)
        XCTAssertEqual(resFailedAmountMin, SplitBillResult.failure(message: "金額が範囲外です"))
        
        let resFailedAmountMax = SplitBillResult.splitBill(payUnit: 100, amount: 100001, peopleNumber: 2)
        XCTAssertEqual(resFailedAmountMax, SplitBillResult.failure(message: "金額が範囲外です"))
        
        let resSucsesAmountMax = SplitBillResult.splitBill(payUnit: 100, amount: 100000, peopleNumber: 2)
        XCTAssertEqual(resSucsesAmountMax, SplitBillResult.sucsess(payment: Payment.init(payPerPerson: 100, kickback: 100)))
        
        // 人数のバリデーション
        let resFailedPeopleMin = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 1)
        XCTAssertEqual(resFailedPeopleMin, SplitBillResult.failure(message: "人数が範囲外です"))
        
        let resFailedPeopleMax = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 11)
        XCTAssertEqual(resFailedPeopleMax, SplitBillResult.failure(message: "人数が範囲外です"))
        
        let resSucsesPeopleMax = SplitBillResult.splitBill(payUnit: 100, amount: 1000, peopleNumber: 10)
        XCTAssertEqual(resSucsesPeopleMax, SplitBillResult.sucsess(payment: Payment.init(payPerPerson: 100, kickback: 100)))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
