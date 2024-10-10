//
//  UserModel.swift
//  RepoFinder
//
//  Created by Bhanuja Tirumareddy on 10/9/24.
//

import Foundation

// MARK: - UserModel
struct RepoModel: Codable,Identifiable {
    let id: Int
    let name:String
    let stargazersCount: Int
    let forksCount: Int
    let description: String?
    let language:String?
    let owner: Owner
    let updatedAt : String
    
}


// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url, htmlUrl, followersUrl: String
    let followingUrl, gistsUrl, starredUrl: String
    let subscriptionsUrl, organizationsUrl, reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
}

extension RepoModel {
    func getLastUpdatedDate() -> Date {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"

        // Convert String to Date
        return dateFormatter.date(from: updatedAt) ?? Date()
    }
    
}
typealias Repos = [RepoModel]

struct Languages: Codable, Hashable, Equatable {
    var id: Int
    var type: String
    var hashValue: Int { get { return type.hashValue } }
}

func ==(left:Languages, right:Languages) -> Bool {
    return left.type == right.type
}



