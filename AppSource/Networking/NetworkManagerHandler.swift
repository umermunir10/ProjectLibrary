//  URLSession+APIHandler.swift
//  LibraryApp
//
//  Created by Faraz on 15/11/2021.

import Foundation
import UIKit

//MARK:- ERRORs Enum
enum URLError: Error {
    case internetError
    case authError
    case noData
    case decodingError
    case timeOutError
    case badURL
}

enum RequestType: String {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
}

public typealias Parameters = [String: Any]

class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL, requetType: RequestType = .GET, params: Parameters? = nil, mediaArray: [Media]? = nil, isJSONBody: Bool = false, completion: @escaping(Result<T, URLError>) -> Void) {
        Utilities.showHUD()
        aPIHandler.fetchData(url: url, requetType: requetType, params: params, mediaArray: mediaArray, isJSONBody: isJSONBody) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                        Utilities.hideHUD()
                    case .failure(let error):
                        completion(.failure(error))
                        Utilities.hideHUD()
                    }
                }
            case .failure(let error):
                completion(.failure(error))
                Utilities.hideHUD()
            }
        }
        
    }
    
    
}

protocol APIHandlerDelegate {
    func fetchData(url: URL, requetType: RequestType, params: Parameters?, mediaArray: [Media]?, isJSONBody:Bool, completion: @escaping(Result<Data, URLError>) -> Void)
}

class APIHandler: APIHandlerDelegate {
    
    func createDataBody(withParameters params: Parameters?, mediaArray: [Media], boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)" + lineBreak)
            }
        }
        
        for photo in mediaArray {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    func fetchData(url: URL, requetType: RequestType = .GET, params: Parameters? = nil, mediaArray: [Media]?, isJSONBody: Bool = false, completion: @escaping(Result<Data, URLError>) -> Void) {
        //Utilities.showHUD()
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        
        urlRequest.httpMethod = requetType.rawValue
        /*
         urlRequest.setValue("ios", forHTTPHeaderField: "Device-Type")
         urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
         urlRequest.setValue(Locale.current.languageCode ?? "en", forHTTPHeaderField: "Language-Code")
         
         /**Uncomment when you want to send authorization in header**/
         
         if let token = CacheManager.shared.setting.user.token {
         print("Token: \(token)")
         urlRequest.setValue(token, forHTTPHeaderField: "token")
         }
         */
        
        if let mediaArray = mediaArray {
            let boundary = "Boundary-\(NSUUID().uuidString)"
            
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let dataBody = createDataBody(withParameters: params, mediaArray: mediaArray, boundary: boundary)
            urlRequest.httpBody = dataBody
        }else if isJSONBody, let param = params {
            let requestData = try? JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            urlRequest.httpBody = requestData
        }else {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = params?.percentEncoded()
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard BReachability.isConnectedToNetwork() else {
                Utilities.showNavigationAlert(URLError.internetError)
                //Utilities.hideHUD()
                completion(.failure(URLError.internetError))
                return
            }
            
            guard error == nil else {
                Utilities.showNavigationAlert(URLError.noData)
                //Utilities.hideHUD()
                completion(.failure(URLError.noData))
                return
            }
            
            guard let data = data, let _ = response else {
                Utilities.showNavigationAlert(URLError.noData)
                //Utilities.hideHUD()
                completion(.failure(URLError.noData))
                return
            }
            //Utilities.hideHUD()
            completion(.success(data))
            
        }.resume()
    }
    
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, URLError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, URLError>) -> Void) {
        
        do {
            let decoder = JSONDecoder()
            
            let formatter = DateFormatter()
            //2022-05-23 04:00:00
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            //decoder.dateDecodingStrategy = .formatted(formatter)
            let decoded = try decoder.decode(T.self, from: data)
            completion(.success(decoded))
        }catch let DecodingError.dataCorrupted(context) {
            print(context)
            completion(.failure(URLError.decodingError))
        } catch let DecodingError.keyNotFound(key, context) {
            debugPrint("Key '\(key)' not found:", context.debugDescription)
            debugPrint("codingPath:", context.codingPath)
            completion(.failure(URLError.decodingError))
        } catch let DecodingError.valueNotFound(value, context) {
            debugPrint("Value '\(value)' not found:", context.debugDescription)
            debugPrint("codingPath:", context.codingPath)
            completion(.failure(URLError.decodingError))
        } catch let DecodingError.typeMismatch(type, context)  {
            debugPrint("Type '\(type)' mismatch:", context.debugDescription)
            debugPrint("codingPath:", context.codingPath)
            completion(.failure(URLError.decodingError))
        } catch {
            debugPrint("error: ", error)
            completion(.failure(URLError.decodingError))
        }
        
        /*
         let commentResponse = try? JSONDecoder().decode(type.self, from: data)
         if let commentResponse = commentResponse {
         return completion(.success(commentResponse))
         } else {
         completion(.failure(.decodingError))
         }
         */
    }
    
}

extension URLSession {
    
    //MARK:- A type safe URL loader that either returns success with value or error
    func jsonDecodableTask<T: Decodable>(with url: URLRequest, completion: @escaping (Result<T, URLError>) -> Void) -> URLSessionDataTask {
        
        
        return self.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard BReachability.isConnectedToNetwork() else {
                    Utilities.showNavigationAlert(URLError.internetError)
                    completion(.failure(URLError.internetError))
                    return
                }
                
                guard error == nil else {
                    Utilities.showNavigationAlert(URLError.noData)
                    completion(.failure(URLError.noData))
                    return
                }
                
                guard let data = data, let _ = response else {
                    Utilities.showNavigationAlert(URLError.noData)
                    completion(.failure(URLError.noData))
                    return
                }
                
                do {
                    
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                }
                
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    completion(.failure(URLError.decodingError))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(URLError.decodingError))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(URLError.decodingError))
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(URLError.decodingError))
                } catch {
                    print("error: ", error)
                    completion(.failure(URLError.decodingError))
                }
            }
        }
    }
    
    /// Data fetched from URLSession is decoded using JSONDecoder
    func jsonDecodableTask<T: Decodable>(urlString: String, requetType: RequestType = .POST, params: Parameters? = nil, mediaArray: [Media]? = nil, completion: @escaping (Result<T, URLError>) -> Void) -> URLSessionDataTask {
        
        var urlRequest = URLRequest(url: URL(string: urlString)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        
        urlRequest.httpMethod = requetType.rawValue
        urlRequest.setValue("ios", forHTTPHeaderField: "Device-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue(Locale.current.languageCode ?? "en", forHTTPHeaderField: "Language-Code")
        
        /**Uncomment when you want o send authorization in header**/
        /*
         if let token = CacheManager.shared.setting.user.token {
         print("Token: \(token)")
         urlRequest.setValue(token, forHTTPHeaderField: "token")
         }
         */
        
        if let mediaArray = mediaArray {
            let boundary = "Boundary-\(NSUUID().uuidString)"
            
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let dataBody = createDataBody(withParameters: params, mediaArray: mediaArray, boundary: boundary)
            urlRequest.httpBody = dataBody
        }
        else {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = params?.percentEncoded()
        }
        
        return self.jsonDecodableTask(with: urlRequest, completion: completion)
    }
    
    func createDataBody(withParameters params: Parameters?, mediaArray: [Media], boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)" + lineBreak)
            }
        }
        
        for photo in mediaArray {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
