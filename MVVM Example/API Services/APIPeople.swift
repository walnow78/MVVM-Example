//
//  APIPeople.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

/// Common api errors
enum APIError: Error {
    case unknownError
    case serverError
    case timeOut
}

struct APIPeople: APIPeopleProtocol {
  
    /// Fetch the people
    /// - returns: Completion handler with collection of person and error
    func fetchPeople(complete: @escaping ( [Person], APIError?) -> ()) {
        complete( [Person](), APIError.unknownError)
    }
}
