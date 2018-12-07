//
//  URLSession.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension URLSession {
    
    //MARK:  sendSynchronousRequest
    func sendSynchronousRequest(_ request: URLRequest, _ completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        let task = self.dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
            semaphore.signal()
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture)
    }
    
    //MARK:  sendAsynchronousRequest
    func sendAsynchronousRequest(_ request: URLRequest, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = self.dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
        return task
    }
}
