//
//  String+Localization.swift
//  Marvel
//
//  Created by Sanket Khairnar on 02/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

extension String {
    func localizedString() -> String {
        NSLocalizedString(self, comment: "")
    }
}
