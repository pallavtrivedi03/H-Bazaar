//
//  WebserviceHelper.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class WebserviceHelper {
    
    private let queue = OperationQueue()
    
    var session: HBURLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetchData(url: URL, shouldCancelOtherOps: Bool, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        if shouldCancelOtherOps {
            queue.cancelAllOperations()
        }
        
        let fetchOperation = BlockOperation { [weak self] in
            let dataTask = self?.session.dataTask(with: url) { (data, response, error) in
                completion(data, response, error)
            }
            dataTask?.resume()
        }
        queue.addOperation(fetchOperation)
    }
    
}
