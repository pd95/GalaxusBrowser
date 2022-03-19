//
//  Helper.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import Foundation

extension Double {
    func currencyFormatted(currency: String) -> String {
        self.formatted(.currency(code: currency))
            .replacingOccurrences(of: currency, with: "")
            .replacingOccurrences(of: ".00", with: ".-")
            .trimmingCharacters(in: .whitespaces)
    }
}
