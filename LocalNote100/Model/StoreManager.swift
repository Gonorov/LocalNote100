//
//  StoreManager.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 10/08/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import UIKit
import StoreKit

class StoreManager: NSObject {
    static var isFullVersion: Bool {
        set {
            UserDefaults.standard.set (newValue, forKey: "IsFull")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "IsFull")
        
        }
    }
        
        func buyFullVersion() {
        if let fullVersionProduct = fullVersionProduct {
        let payment = SKPayment(product: fullVersionProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        }
    }
    
    func restoreFullVersion() {
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }

extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue,updatedTransactions transactions: [SKPaymentTransaction]){
        for transaction in transactions {
            if transaction.transactionState == .deferred {
                print("transaction is deferred")
            }
            if transaction.transactionState == .failed {
                print("transaction is failed")
                print("Error: \(transaction.error?.localizedDescription ?? "Not defained")")
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchased {
                print("transaction is purchased")
                if transaction.payment.productIdentifier == idFullVersion {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchasing {
                print("transaction is purchasing")
            }
            if transaction.transactionState == .restored {
                print("transaction is restored")
                if transaction.payment.productIdentifier == idFullVersion {
                StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue,restoreCompletedTransactionsFailedWithError error: Error){
    }
}
