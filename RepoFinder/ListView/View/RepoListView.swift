//
//  ContentView.swift
//  RepoFinder
//
//  Created by Bhanuja Tirumareddy on 10/9/24.
//

import SwiftUI

struct RepoListView: View {
    @ObservedObject var viewmodel = RepoViewModel()
    @State var isFilterTapped = false
    
    
    var filteredRepoList: [RepoModel] {
        if (viewmodel.selectedLanguage == nil || viewmodel.selectedLanguage?.type == "All" ){
            return viewmodel.repolist
        } else  {
            return viewmodel.repolist.filter {
                let lang = $0.language ?? "All"
                return lang == viewmodel.selectedLanguage?.type
                
            }
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.white.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Picker("Choose", selection: $viewmodel.selectedLanguage, content: {
                            ForEach(viewmodel.languages, id:\.self) { language in
                                Text(language.type).tag(language as Languages?)
                            }
                        })
                    }
                    
                    
                    List(filteredRepoList, id: \.id) { repo in
                        NavigationLink(destination: RepoListDetailView(repo: repo)) {
                            VStack(alignment: .leading,spacing: 10) {
                                
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
                                
                            }
                            .padding()
                        }
                    }
                }
                
                if viewmodel.isDataLoading {
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                }
            }
            .navigationTitle("Repo List")
        }
        .task {
            
            viewmodel.getRepoList(userName: "google")
            
        }
        .alert(isPresented: $viewmodel.showError) {
            Alert(title: Text("Error"),message: Text(viewmodel.errorMessage))
        }
        
    }
    
}

#Preview {
    RepoListView()
}
