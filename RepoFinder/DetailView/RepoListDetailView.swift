//
//  RepoListDetailView.swift
//  RepoFinder
//
//  Created by Bhanuja Tirumareddy on 10/10/24.
//

import SwiftUI

struct RepoListDetailView: View {
    var repo:RepoModel
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter
    }
    
    var body: some View {
        
        VStack(spacing:12) {
            AsyncImage(url: URL(string: repo.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Circle()
                    .fill(.gray)
            }.frame(width:100)

            
            Text(repo.name)
                 .font(.subheadline)
                     .fontWeight(.medium)
             Text(repo.description ?? "")
                 .font(.caption)
                      .fontWeight(.medium)
            HStack(spacing:12) {
                Image(systemName: "star")
                    .imageScale(.small)
                    .foregroundStyle(.tint)
                Text(String(repo.stargazersCount))
                    .font(.caption2)
                    .fontWeight(.medium)
                Image(systemName: "gear")
                    .imageScale(.small)
                    .foregroundStyle(.tint)
                Text(String(repo.forksCount))
                    .font(.caption2)
                    .fontWeight(.medium)
                
                Image(systemName: "book")
                    .imageScale(.small)
                    .foregroundStyle(.tint)
                Text(String(repo.language ?? ""))
                    .font(.caption2)
                    .fontWeight(.medium)
                
               
            }
            Text(dateFormatter.string(from: repo.getLastUpdatedDate()))
                .font(.caption)
                     .fontWeight(.medium)
            
                     .padding()
            Spacer()
        }
        
    }
}

#Preview {
    RepoListDetailView(repo: RepoModel(id: 0, name: "RepoMock", stargazersCount: 10, forksCount: 10, description: "test", language: "swift", owner: Owner(login: "btirumareddy", id: 11805174, nodeId: "MDQ6VXNlcjExODA1MTc0", avatarUrl: "https://avatars.githubusercontent.com/u/11805174?v=4", gravatarId: "https://github.com/btirumareddy"  , url: "https://api.github.com/users/btirumareddy", htmlUrl: "", followersUrl: "https://api.github.com/users/btirumareddy/following{/other_user}", followingUrl:"https://api.github.com/users/btirumareddy/followers", gistsUrl: "https://api.github.com/users/btirumareddy/gists{/gist_id}", starredUrl: "https://api.github.com/users/btirumareddy/starred{/owner}{/repo}", subscriptionsUrl: "https://api.github.com/users/btirumareddy/subscriptions", organizationsUrl: "https://api.github.com/users/btirumareddy/orgs", reposUrl: "https://api.github.com/users/btirumareddy/repos", eventsUrl: "https://api.github.com/users/btirumareddy/events{/privacy}", receivedEventsUrl: "https://api.github.com/users/btirumareddy/received_events", type: "User", siteAdmin: false), updatedAt:"2020-06-25T09:55:25Z"))
}
