//
//  DateFormatter+Extension.swift
//  WorldOfPayback
//
//  Created by Marcin Golli on 16/05/2023.
//

import Foundation

extension DateFormatter {
    static var apiDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }
}
