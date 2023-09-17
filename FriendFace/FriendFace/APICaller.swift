//
//  APICaller.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    func getUsersList(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            completion(.failure(URLError(.badURL)))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil else {return}
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode([User].self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
    
    
}
