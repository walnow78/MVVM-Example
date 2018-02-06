//
//  PersonViewController.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personPhoneLabel: UILabel!
    
    /// View model
    var viewModel: PersonViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Person", comment: "")
        
        guard let viewModel = viewModel else { return }
        
        personNameLabel.text = viewModel.name
        personPhoneLabel.text = viewModel.phone
    }
}

