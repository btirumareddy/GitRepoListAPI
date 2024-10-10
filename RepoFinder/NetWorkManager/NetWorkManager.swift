//
//  NetWorkManager.swift
//  RepoFinder
//
//  Created by Bhanuja Tirumareddy on 10/9/24.
//

import Foundation

final class NetWorkManager {
    static let shared = NetWorkManager()
    let baseseURL = "https://api.github.com/users/"
    let repoURL = "/repos"
    
    func getReposListOfUSer(userName : String) async throws -> Repos {
        
        let reposGetURL = baseseURL + userName + repoURL
        
        guard let url = URL(string: reposGetURL) else { throw  RFError.invalidURL}
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else { throw RFError.invalidResponse}
        
        do
        {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Repos.self, from: data)
        }
        catch {
            throw RFError.invalidData
        }    
    }
}

enum RFError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
