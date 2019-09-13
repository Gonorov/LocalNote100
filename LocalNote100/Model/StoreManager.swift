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
        } else {
           if !SKPaymentQueue.canMakePayments(){
                print ("Не возможно делать покупки")
                return
            }
            
            let request = SKProductsRequest(productIdentifiers: [idFullVersion])
            request.delegate = self
            request.start()
            }
    }
    
    func restoreFullVersion() {
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }

extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse){
        //let count = response.invalidProductIdentifiers.count
        if response.invalidProductIdentifiers.count != 0 {
            print ("Есть неактуальные продукты: \(response.invalidProductIdentifiers)")
            
        }
        
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print ("Получили продукт в StoreManager: \(fullVersionProduct?.localizedTitle ?? "Title Not Defaned") / \( fullVersionProduct?.localizedDescription ?? "Description Not Defaned")")
            self.buyFullVersion()
            
        }
        
        
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


class BuyingForm {
    
    var isNeedToShow: Bool {
        if StoreManager.isFullVersion {
           return false
        }
        if notes.count <= 3 {
            // MARK: - AG
            print("Note.count=\(notes.count)")
           return false
        }
        return true
    }
    var storeManager = StoreManager()
    
    func showForm(inController: UIViewController){
        if let fullVersionProduct = fullVersionProduct{
            let alertController = UIAlertController(title: fullVersionProduct.localizedTitle, message: fullVersionProduct.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            
            let actionBuy = UIAlertAction(title: "Buy for \(fullVersionProduct.price) \(String(describing: fullVersionProduct.priceLocale.currencySymbol!))", style: UIAlertAction.Style.default, handler: {(alert) in
            self.storeManager.buyFullVersion()
            })
            let actionRestore = UIAlertAction(title: "Restore", style: UIAlertAction.Style.default, handler: {(alert) in
            self.storeManager.restoreFullVersion()
            })
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(alert) in
            
            })
            
            alertController.addAction(actionBuy)
            alertController.addAction(actionRestore)
            alertController.addAction(actionCancel)
            
            inController.present(alertController, animated: true, completion: nil)
        }
    }
}
