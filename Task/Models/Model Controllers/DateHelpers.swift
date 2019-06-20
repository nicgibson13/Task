//
//  DateHelpers.swift
//  Task
//
//  Created by Nic Gibson on 6/19/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
