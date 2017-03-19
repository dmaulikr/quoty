//
//  QuoteResource.swift
//  quoty
//
//  Created by Marvin Messenzehl on 16.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import Foundation

class QuoteResource {
    
    //old api
    //let urlText: String = "http://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=jsonp&lang=en&jsonp=?"
    
    //
    func getUrlString() -> String {
        
        let urlBase = "quotesondesign.com"
        let urlSub = "wp-json/posts"
        let urlConfig = "filter[orderby]=rand&filter[posts_per_page]=1"
        
        return "http://\(urlBase)/\(urlSub)?\(urlConfig)"
    }
    
    
    // MARK: Download data
    
    func fetchData(completion: @escaping (_ response: Quote) -> ()) {
        
        let queue = DispatchQueue.global(qos: .background)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        //async download
        queue.async {
            guard let urlObj = URL(string: self.getUrlString()) else {
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
        
        guard let jsonArr = parseJson(data: fromData) else {
            print("problem with json parsing")
            return nil
        }
        
        // TODO: read out the data from json
        print(jsonArr)
        
        //build response
        let response = Quote(author: "", text: "")
        return response
        
    }
    
    
    private func parseJson(data: Data) -> NSArray? {
        do {
            let jsonArr = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray
            return jsonArr
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
