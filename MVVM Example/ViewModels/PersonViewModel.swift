//
//  PersonViewModel.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

class PersonViewModel {
    
    /// Full name
    var name: String {
        return "\(firstName) \(lastName)"
    }
    
    /// Phone number
    var phone: String {
        return phoneNumber
    }
    
    private let firstName: String
    private let lastName: String
    private let phoneNumber: String
    
    // MARK: - Inits
    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
