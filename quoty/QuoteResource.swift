//
//  QuoteResource.swift
//  quoty
//
//  Created by Marvin Messenzehl on 16.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import Foundation

class QuoteResource {
    
    let urlText: String = "http://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=jsonp&lang=en&jsonp=?"
    
    
    // MARK: Download data
    
    func downloadData(completion: @escaping (_ response: Quote) -> ()) {
        
        let queue = DispatchQueue.global(qos: .background)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        //async download
        queue.async {
            guard let urlObj = URL(string: self.urlText) else {
                print("problem while creating url object")
                return
            }
            
            let task = session.dataTask(with: urlObj, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data,
                    let apiResponse = self.createResponse(fromData: data) else {
                        print("no data?")
                        return
                }
                
                DispatchQueue.main.async {
                    completion(apiResponse)
                }
            })
            
            task.resume()
        }
    }
    
    
    
    // MARK: Response
    
    private func createResponse(fromData: Data) -> Quote? {
        
        guard let jsonDict = parseJson(data: fromData) else {
            print("problem with json parsing")
            return nil
        }
        
        // TODO: read out the data from json
        print(jsonDict)
        
        //build response
        let response = Quote(author: "", text: "")
        return response
        
    }
    
    
    private func parseJson(data: Data) -> NSDictionary? {
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            return jsonDict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
