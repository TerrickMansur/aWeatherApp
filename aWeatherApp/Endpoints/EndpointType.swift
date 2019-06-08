//
//  EndpointType.swift
//  aWeatherApp
//
//  Created by Terrick Mansur on 6/8/19.
//  Copyright © 2019 Terrick Mansur. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveKit

protocol Endpoint {
    
    var location: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var encoding: URLEncoding { get }
    var sessionHeader: [String:String]? { get }
}

extension Endpoint {
    
    @discardableResult
    func request(completion: @escaping (DataResponse<Data>)->(Void)) -> DataRequest {
        return Alamofire.request(
            self.location,
            method: self.method,
            parameters: self.parameters,
            encoding: self.encoding,
            headers: self.sessionHeader).responseData(completionHandler: completion)
    }
    
    func signal() -> Signal<Data, Error> {
        return Signal<Data, Error> { observer in
            let request = self.request(completion: { data in
                switch data.result {
                case .failure(let error):
                    observer.failed(error)
                case .success(let data):
                    observer.completed(with: data)
                }
            })
            
            return BlockDisposable {
                request.cancel()
            }
        }
    }
}

