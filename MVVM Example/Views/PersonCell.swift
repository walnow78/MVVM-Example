//
//  PersonCell.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    /// Cell id
    static let cellId = "personCellId"
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personPhoneLabel: UILabel!
    
    var viewModel: PersonViewModel! {
        didSet {
            personNameLabel.text = viewModel.name
            personPhoneLabel.text = viewModel.phone
        }
    }
}
