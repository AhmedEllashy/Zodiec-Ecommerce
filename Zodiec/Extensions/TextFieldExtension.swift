//
//  TextField.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 23/07/2023.
//

import UIKit

extension UITextField {
    func isValid() -> Bool{
        guard let text = self.text,
              !text.isEmpty else{
            return false
    }
        return true
   }
}

