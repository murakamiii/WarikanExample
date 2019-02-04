//
//  SplitBill.swift
//  WarikanExample
//
//  Created by MURAKAMI on 2019/02/04.
//  Copyright © 2019 MURAKAMI. All rights reserved.
//

import Foundation

enum SplitBillResult: Equatable {
    case sucsess(payment: Payment)
    case failure(message: String)
    
    
    private static let PayUnitMin = 100
    private static let PayUnitMax = 10_000
    private static let PeopleMin = 2
    private static let PeopleMax = 10
    private static let AmountMin = 1_000
    private static let AmountMax = 100_000
    
    static func splitBill(payUnit: UInt, amount: UInt, peopleNumber: UInt) -> SplitBillResult {
        guard (PayUnitMin...PayUnitMax).contains(Int(payUnit)) else {
            return SplitBillResult.failure(message: "支払単位が範囲外です")
        }
        
        guard (AmountMin...AmountMax).contains(Int(amount)) else {
            return SplitBillResult.failure(message: "金額が範囲外です")
        }
        
        guard (PeopleMin...PeopleMax).contains(Int(peopleNumber)) else {
            return SplitBillResult.failure(message: "人数が範囲外です")
        }
        
        return SplitBillResult.sucsess(payment: Payment.init(payUnit: payUnit,
                                                             amount: amount,
                                                             peopleNumber: peopleNumber))
    }
}

fileprivate extension UInt {
    func zeroOrOne() -> UInt {
        return self == 0 ? 0 : 1
    }
}

struct Payment: Equatable {
    let payPerPerson: UInt
    let kickback: UInt

    init(payUnit: UInt, amount: UInt, peopleNumber: UInt) {
        let fraction = amount % payUnit
        let units = amount / payUnit + fraction.zeroOrOne()
        payPerPerson = UInt(ceil(Double(units) / Double(peopleNumber))) * payUnit
        kickback = peopleNumber * payPerPerson - amount
    }
    
}


