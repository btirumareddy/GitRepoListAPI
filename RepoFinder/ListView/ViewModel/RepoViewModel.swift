//
//  UserViewModel.swift
//  RepoFinder
//
//  Created by Bhanuja Tirumareddy on 10/10/24.
//

import Foundation


class RepoViewModel : ObservableObject {
    @Published var repolist:Repos = []
    @Published var errorMessage = ""
    @Published var isDataLoading = false
    @Published var showError = false
    @Published var languages:[Languages] = []
    @Published var selectedLanguage: Languages? = nil
    
    func getRepoList(userName : String) {
        isDataLoading = true
        Task {
            @MainActor in            
            do {
                self.repolist = try await NetWorkManager.shared.getReposListOfUSer(userName: userName)
                
                self.languages = getLangModels()
                self.selectedLanguage = languages.first
                isDataLoading = false
            }
            catch(let error) {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
                showError = true
            }
        }
        
    }
    
    func getLangModels() -> [Languages] {
        var localnguages:[Languages] = []
        
        for repo in repolist {
            if let lang = repo.language {
                
                localnguages.append(Languages(id: repo.id, type: lang))
            }
        }
        
        var uniqueLang = Array(Set(localnguages))
        let allLang = (Languages(id: 0, type: "All"))
        uniqueLang.insert(allLang, at: 0)
        return uniqueLang
    }
    
}


