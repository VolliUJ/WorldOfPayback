import Quick
import Nimble
import Foundation

@testable import WorldOfPayback

class TransactionSpec: QuickSpec {
    override func spec() {
        var decoder: JSONDecoder!
        
        beforeEach {
            decoder = JSONDecoder()
        }
        
        describe("Decoding Transaction Model") {
            context("Contains TransactionDetails.description") {
                it("should decode JSON successfully") {
                    let jsonString = """
                    {
                        "partnerDisplayName" : "REWE Group",
                        "alias" : {
                            "reference" : "795357452000810"
                        },
                        "category" : 1,
                        "transactionDetail" : {
                            "description" : "Punkte sammeln",
                            "bookingDate" : "2022-07-24T10:59:05+0200",
                            "value" : {
                                "amount" : 124,
                                "currency" : "PBP"
                            }
                        }
                    }
                    """
                    
                    let jsonData = jsonString.data(using: .utf8)!
                    
                    expect {
                        let transaction = try decoder.decode(Transaction.self, from: jsonData)
                        expect(transaction.partnerDisplayName).to(equal("REWE Group"))
                        expect(transaction.alias.reference).to(equal("795357452000810"))
                        expect(transaction.category).to(equal(.incoming))
                        expect(transaction.transactionDetail.description).to(equal("Punkte sammeln"))
                        
                        let dateString = DateFormatter.apiDateFormatter.string(from: transaction.transactionDetail.bookingDate)
                        expect(dateString).to(equal("2022-07-24T10:59:05+0200"))
                        
                        expect(transaction.transactionDetail.value.amount).to(equal(124))
                        expect(transaction.transactionDetail.value.currency).to(equal("PBP"))
                    }.notTo(throwError())
                    
                }
            }
            
            context("Doesn't contain TransactionDetails.description") {
                it("should decode JSON successfully") {
                    let jsonString = """
                    {
                        "partnerDisplayName" : "REWE Group",
                        "alias" : {
                            "reference" : "795357452000810"
                        },
                        "category" : 1,
                        "transactionDetail" : {
                            "bookingDate" : "2022-07-24T10:59:05+0200",
                            "value" : {
                                "amount" : 124,
                                "currency" : "PBP"
                            }
                        }
                    }
                    """
                    
                    let jsonData = jsonString.data(using: .utf8)!
                    
                    expect {
                        let transaction = try decoder.decode(Transaction.self, from: jsonData)
                        expect(transaction.partnerDisplayName).to(equal("REWE Group"))
                        expect(transaction.alias.reference).to(equal("795357452000810"))
                        expect(transaction.category).to(equal(.incoming))
                        expect(transaction.transactionDetail.description).to(beNil())
                        
                        let dateString = DateFormatter.apiDateFormatter.string(from: transaction.transactionDetail.bookingDate)
                        expect(dateString).to(equal("2022-07-24T10:59:05+0200"))
                        
                        expect(transaction.transactionDetail.value.amount).to(equal(124))
                        expect(transaction.transactionDetail.value.currency).to(equal("PBP"))
                    }.notTo(throwError())
                }
            }
        }
    }
}
