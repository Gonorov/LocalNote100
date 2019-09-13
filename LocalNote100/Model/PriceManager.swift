//
//  PriceManager.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 28/07/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//  ProductID: LocationNoteAG.FullVersion
//

import UIKit
import StoreKit

var fullVersionProduct: SKProduct?

let idFullVersion = "LocationNoteAG.FullVersion"

class PriceManager: NSObject {
    
    func getPriceForProduct(idProduct: String){
        if !SKPaymentQueue.canMakePayments(){
            print ("Не возможно делать покупки")
            return
        }
    
        let request = SKProductsRequest(productIdentifiers: [idProduct])
        request.delegate = self
        request.start()
    }

}

extension PriceManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse){
        //let count = response.invalidProductIdentifiers.count
        if response.invalidProductIdentifiers.count != 0 {
            print ("Есть неактуальные продукты: \(response.invalidProductIdentifiers)")
            
        }
        
        if response.products.count > 0 {
            fullVersionProduct = response.products[0]
            print ("Получили продукт: \(fullVersionProduct?.localizedTitle ?? "Title Not Defaned") / \( fullVersionProduct?.localizedDescription ?? "Description Not Defaned")")
            
        }
        
        
    }
}
