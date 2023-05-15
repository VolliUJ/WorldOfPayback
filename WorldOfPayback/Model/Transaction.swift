//
//  Transaction.swift
//  WorldOfPayback
//
//  Created by Marcin Golli on 15/05/2023.
//

import Foundation

struct Transaction: Codable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Category
    let transactionDetail: TransactionDetail
    
    struct Alias: Codable {
        let reference: String
    }
    
    enum Category: Int, Codable {
        case incoming = 1
        case outgoing = 2
        case unknown
        
        init(from decoder: Decoder) throws {
             let container = try decoder.singleValueContainer()
             if let intValue = try? container.decode(Int.self) {
                 self = Category(rawValue: intValue) ?? .unknown
             } else {
                 self = .unknown
             }
         }
         
         func encode(to encoder: Encoder) throws {
             var container = encoder.singleValueContainer()
             try container.encode(rawValue)
         }
    }
    
    struct TransactionDetail: Codable {
        let description: String?
        let bookingDate: Date
        let value: Value
        
        struct Value: Codable {
            let amount: Int
            let currency: String
        }
        
        enum CodingKeys: String, CodingKey {
            case description
            case bookingDate
            case value
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            description = try? container.decode(String.self, forKey: .description)
            value = try container.decode(Value.self, forKey: .value)
            
            let dateString = try container.decode(String.self, forKey: .bookingDate)
            let formatter = ISO8601DateFormatter()
            bookingDate = formatter.date(from: dateString)!
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try? container.encode(description, forKey: .description)
            try container.encode(value, forKey: .value)
            
            let formatter = ISO8601DateFormatter()
            let dateString = formatter.string(from: bookingDate)
            try container.encode(dateString, forKey: .bookingDate)
        }
    }
}
