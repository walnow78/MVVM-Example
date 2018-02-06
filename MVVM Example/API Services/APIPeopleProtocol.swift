//
//  APIPeopleProtocol.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import Foundation

/// Api people service protoocl
protocol APIPeopleProtocol {
    func fetchPeople( complete: @escaping (_ photos: [Person], _ error: APIError? )->() )
}
