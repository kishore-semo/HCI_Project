//
//  RegisterModel.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import Foundation
import Alamofire

enum NetworkError: Error{
    case error(message: String)
    var localizedString: String{
        switch self {
        case .error(let message):
            return message
        }
    }
}

struct ApiManager {
    static func fetch(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(message: "URL forbidden")))
            return
        }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response  in
            //LoadingOverlay.shared.hideOverlayView()
            guard let data = response.data else {return}
            switch response.result{
            case .success(_):
                if response.response?.statusCode == 200{
                    completion(.success(data))
                }else{
                    completion(.failure(.error(message: "Data not found")))
                }
            case .failure(let error):
                completion(.failure(.error(message: error.localizedDescription)))
            }
        }
    }
}
