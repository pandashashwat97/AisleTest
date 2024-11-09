//
//  NetworkCall.swift
//  AisleTest
//
//  Created by Shashwat Panda on 09/11/24.
//

import Foundation

class NetworkCall {
    
    // Define the base URL and endpoint
    let baseURL = "https://app.aisle.co/V1"
    let endpointLogin = "/users/phone_number_login"
    let endpointOtp = "/users/phone_number_login"
    let endpointApi = "/users/test_profile_list"
    var fullURLLogin: URL {
        URL(string: baseURL + endpointLogin)!
    }
    var fullURLOtp: URL {
        URL(string: baseURL + endpointOtp)!
    }
    var fullURLApi: URL {
        URL(string: baseURL + endpointOtp)!
    }

    
    func postData(number: String, otp: String?, completion: @escaping ([String: Any])->Void ){
        
        // Define the parameters (as a dictionary)
        let parameters: [String: Any] = {
            if let otp = otp {
                ["number" : number,
                 "otp": otp
                ]
            } else {
                ["number" : number
                ]
            }
        }()
        // Convert parameters to JSON data
        var jsonData: Data
            
        do {
            jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        // Create the URLRequest object
        var request = URLRequest(url: (otp != nil ? fullURLOtp: fullURLLogin))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Create the network call with URLSession
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Network request failed with error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    // Try to decode the response data
                    if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(responseJSON)
                    }
                } catch {
                    print("Failed to decode response data: \(error)")
                }
            }
        }
        task.resume()
    }
    
    // Auth header coming nil as submition time elapsed
    func getData(header: String?) {
        
    }
}

