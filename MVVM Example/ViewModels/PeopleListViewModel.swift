//
//  PeopleListViewModel.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

class PeopleListViewModel {
    
    var reloadData: (()->())?
    var showAlert: ((String)->())?
    var loadingStatus: ((Bool)->())?
    
    private let apiService: APIPeopleProtocol
    
    /// Data model
    private var people: [Person] = [] {
        didSet {
            self.reloadData?()
        }
    }
    
    /// Flag loading data
    private var isLoading: Bool = false {
        didSet {
            loadingStatus?(isLoading)
        }
    }
    
    /// Flag alert message
    private var alertMessage: String = "" {
        didSet {
            showAlert?(alertMessage)
        }
    }

    // MARK: - Inits
    
    init(apiService: APIPeopleProtocol) {
        self.apiService = apiService
    }
    
    // MARK: - Public methods
    
    /// Fetch the people from api service
    func fetchPeople() {
        self.isLoading = true
        apiService.fetchPeople { (people, error) in
            self.isLoading = false
            if error == nil {
                self.people = people
            } else {
                if let errorMessage = error {
                    self.alertMessage = (errorMessage.localizedDescription)
                    self.people = people
                    
                }
            }
        }
    }

    /// Create personviewmodel from datamodel
    /// - parameter: indexpath: selected indexpath in tableview
    /// - returns: personcellviewmodel
    func personViewModel(at indexPath: IndexPath) -> PersonViewModel {
        let person = people[indexPath.row]
        
        let personViewModel = PersonViewModel(firstName: person.firstName, lastName: person.lastName, phoneNumber: person.phoneNumber)
        
        return personViewModel
        
    }
    
    /// Return the number of person from the model
    /// - returns: Number of person
    func numberOfRows() -> Int{
        return people.count
    }
}

