//
//  Person.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

/// Model of person
struct Person: Codable {
    /// First name
    let firstName: String
    /// Last name
    let lastName: String
    /// Phone number
    let phoneNumber: String
}
