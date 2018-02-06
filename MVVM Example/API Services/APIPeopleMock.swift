//
//  APIPeopleMock.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

struct APIPeopleMock: APIPeopleProtocol {
 
    /// Fetch the people
    /// - returns: Completion handler with collection of person and error
    func fetchPeople(complete: @escaping ( [Person], APIError?) -> ()) {
        
        if let url = Bundle.main.url(forResource: "People", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let people = try decoder.decode([Person].self, from: data)
                complete(people, nil)
            } catch {
                complete([Person](), nil)
            }
        }
    }
}
