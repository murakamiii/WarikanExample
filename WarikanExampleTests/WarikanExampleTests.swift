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
    
    func testSplitBill() {
        let p1 = Payment.init(payUnit: 100, amount: 1000, peopleNumber: 2)
        XCTAssertEqual(p1._fraction, 0)
        XCTAssertEqual(p1._units, 10)
        XCTAssertEqual(p1._payPerPerson, 500)
        XCTAssertEqual(p1._kickback, 0)
        
        let p2 = Payment.init(payUnit: 100, amount: 1000, peopleNumber: 3)
        XCTAssertEqual(p2._fraction, 0)
        XCTAssertEqual(p2._units, 10)
        XCTAssertEqual(p2._payPerPerson, 400)
        XCTAssertEqual(p2._kickback, 200)
        
        let p3 = Payment.init(payUnit: 100, amount: 1001, peopleNumber: 3)
        XCTAssertEqual(p3._fraction, 1)
        XCTAssertEqual(p3._units, 11)
        XCTAssertEqual(p3._payPerPerson, 400)
        XCTAssertEqual(p3._kickback, 199)
        
        let p4 = Payment.init(payUnit: 101, amount: 2020, peopleNumber: 10)
        XCTAssertEqual(p4._fraction, 0)
        XCTAssertEqual(p4._units, 20)
        XCTAssertEqual(p4._payPerPerson, 202)
        XCTAssertEqual(p4._kickback, 0)
    }
}
