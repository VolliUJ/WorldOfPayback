//
//  TransactionResponse.swift
//  WorldOfPayback
//
//  Created by Marcin Golli on 15/05/2023.
//

import Foundation

struct TransactionResponse: Codable {
    let items: [Transaction]
}
