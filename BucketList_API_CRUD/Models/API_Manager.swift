//
//  API_Manager.swift
//  BucketList_API_CRUD
//
//  Created by Atheer Alahmari on 23/05/1443 AH.
//

import Foundation
class API_Manager {
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "objective=\(objective)"
            request.httpBody = bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "DELETE"
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "id=\(id)"
            request.httpBody = bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    static func putTask(id: Int, objective: String,  completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "PUT"
            // Create some bodyData and attach it to the HTTPBody
            do{
                
                let bodyData = try JSONSerialization.data(withJSONObject: ["objective":objective])
                request.httpBody = bodyData
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}


