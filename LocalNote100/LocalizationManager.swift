//
//  LocalizationManager.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 07/09/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
