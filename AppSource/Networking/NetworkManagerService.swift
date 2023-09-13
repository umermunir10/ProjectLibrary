//
//  klklkl.swift
//  Kisma-iOS
//
//  Created by shehzad on 18/05/2022.
//

import Foundation

protocol NetworkServiceDelegate: /*LibrayRequestDelegate, SearchRequestDelegate,*/ AuthRequestDelegate/*, ReceiptValidateDelegate */{ }

//protocol ReceiptValidateDelegate {
//    func validateReceipt(appleServer: String, completion: @escaping(Result<IAPReceiptResponse, URLError>) -> Void)
//}

//protocol SearchRequestDelegate {
//
//    func fetchSearchAllData(completion: @escaping(Result<BaseResponeModel<BookData>, URLError>) -> Void)
//    func fetchSearchData(searchedString: String, completion: @escaping(Result<BaseResponeModel<[Book]>, URLError>) -> Void)
//    func subscribeBook(userId: Int, bookId: Int, subscriptionFlag: Bool, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
//}

//protocol LibrayRequestDelegate {
//
//    func fetchLibraryData(userId: Int, completion: @escaping(Result<BaseResponeModel<[Book]>, URLError>) -> Void)
//}

protocol AuthRequestDelegate {
    
    func getSignedUp(phoneNumber: String, completion: @escaping(Result<Login, URLError>) -> Void)
    
    func getVerifiedAndProfileData(phoneNumber: String, code: String, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
    
    func updateProfileData(name: String, userId: Int , imageData: Data?, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
    
    //    func fetchProfileData(userId: Int, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
    //    func updateSubscription(subscription: Subscription, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
    //    func deleteProfileData(userId: Int, completion: @escaping(Result<VerificationRsponse, URLError>) -> Void)
}

class NetworkManagerService: NetworkServiceDelegate  {
    
    //    func validateReceipt(appleServer: String, completion: @escaping (Result<IAPReceiptResponse, URLError>) -> Void) {
    //
    //        let receiptFileURL = Bundle.main.appStoreReceiptURL
    //        //let appleServer = receiptFileURL?.lastPathComponent == "sandboxReceipt" ? "sandbox" : "buy"
    //        guard let url = URL(string: "https://\(appleServer).itunes.apple.com/verifyReceipt") else {
    //            return completion(.failure(.badURL))
    //        }
    //        guard let receiptFileURL = receiptFileURL else { return }
    //        let receiptData = try? Data(contentsOf: receiptFileURL)
    //        guard let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) else { return completion(.failure(.noData)) }
    //        let params: Parameters = ["receipt-data" : recieptString, "password" : "0a0e4e74682a49f7bab269560a352a19"]
    //        NetworkManager().fetchRequest(type: IAPReceiptResponse.self, url: url, requetType: .POST, params: params, isJSONBody: true, completion: completion)
    //}
    
    //    func updateSubscription(subscription: Subscription, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/subscription") else {
    //            return completion(.failure(.badURL))
    //        }
    //        var params:Parameters = [:]
    //        if let userId = subscription.userId {
    //            params["user_id"] = userId
    //        }
    //        if let subscriptionName = subscription.subscriptionName {
    //            params["subscription_name"] = subscriptionName
    //        }
    //        if let subscriptionType = subscription.subscriptionType {
    //            params["subscription_type"] = subscriptionType
    //        }
    //        if let startDateString = subscription.startDateString {
    //            params["start_date"] = startDateString
    //        }
    //        if let endDateString = subscription.endDateString {
    //            params["end_date"] = endDateString
    //        }
    //
    //        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, completion: completion)
    //  }
    
    //    func fetchProfileData(userId: Int, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/fetchprofile") else {
    //            return completion(.failure(.badURL))
    //        }
    //        let params: Parameters = ["user_id" : userId]
    //        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, completion: completion)
    //    }
    //
    //    func deleteProfileData(userId: Int, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/deleteprofile") else {
    //            return completion(.failure(.badURL))
    //        }
    //        let params: Parameters = ["user_id" : userId]
    //        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, completion: completion)
    //    }
    
    
    func getVerifiedAndProfileData(phoneNumber: String, code: String, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
        guard let url = URL(string: "\(kBaseURL)/codeverification") else {
            return completion(.failure(.badURL))
        }
        let params: Parameters = ["number" : phoneNumber, "code" : code ]
        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, mediaArray: nil, completion: completion)
    }
    
    func getSignedUp(phoneNumber: String, completion: @escaping (Result<Login, URLError>) -> Void) {
        guard let url = URL(string: "\(kBaseURL)/signup") else {
            return completion(.failure(.badURL))
        }
        let params: Parameters = ["phone_number" : phoneNumber]
        NetworkManager().fetchRequest(type: Login.self, url: url, requetType: .POST, params: params, mediaArray: nil, completion: completion)
    }
    
    
    func updateProfileData(name: String, userId: Int, imageData: Data? = nil, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
        guard let url = URL(string: "\(kBaseURL)/profile") else {
            return completion(.failure(.badURL))
        }
        let params: Parameters = ["name" : name , "id" : userId]
        var mediaArray = [Media]()
        if let imageData = imageData {
            mediaArray.append(Media(withFile: imageData, fileName: "\(userId).png", forKey: "image"))
        }
        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, mediaArray: mediaArray, completion: completion)
    }
    
    //    func fetchSearchAllData(completion: @escaping (Result<BaseResponeModel<BookData>, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/AllBookData") else {
    //            return completion(.failure(.badURL))
    //        }
    //        NetworkManager().fetchRequest(type: BaseResponeModel<BookData>.self, url: url, completion: completion)
    //    }
    //
    //    func fetchSearchData(searchedString: String, completion: @escaping (Result<BaseResponeModel<[Book]>, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/SearchBook?key=\(searchedString)") else {
    //            return completion(.failure(.badURL))
    //        }
    //        NetworkManager().fetchRequest(type: BaseResponeModel<[Book]>.self, url: url, completion: completion)
    //    }
    //
    //    func subscribeBook(userId: Int, bookId: Int, subscriptionFlag: Bool, completion: @escaping (Result<VerificationRsponse, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/SubcribeBook") else {
    //            return completion(.failure(.badURL))
    //        }
    //        let params: Parameters = ["user_id" : userId , "book_id" : bookId, "flag": subscriptionFlag]
    //        NetworkManager().fetchRequest(type: VerificationRsponse.self, url: url, requetType: .POST, params: params, completion: completion)
    //    }
    
    
    //    func fetchLibraryData(userId: Int, completion: @escaping (Result<BaseResponeModel<[Book]>, URLError>) -> Void) {
    //        guard let url = URL(string: "\(kBaseURL)/UserSubcribedBook?userid=\(userId)") else {
    //            return completion(.failure(.badURL))
    //        }
    //        NetworkManager().fetchRequest(type: BaseResponeModel<[Book]>.self, url: url, completion: completion)
    //    }
}
