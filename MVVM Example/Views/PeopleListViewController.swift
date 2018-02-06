//
//  PeopleListViewController.swift
//  MVVM Example
//
//  Created by Walicki, Pawel on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import UIKit

class PeopleListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
        }
    }
    
    /// Activity indicator
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    /// Viewmodel
    lazy var viewModel: PeopleListViewModel = {
        return PeopleListViewModel(apiService: APIPeopleMock())
    }()
    
    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("People", comment: "")
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "showPerson",
            let destinationVC = segue.destination as? PersonViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                return
        }
        
        destinationVC.viewModel = viewModel.personViewModel(at: indexPath)
        
    }
    
    // MARK: - Private methods -
    
    /// Show or hide the activity indicator
    /// - parameter: isLoading: Flag for show or hide the indicator
    /// - returns: comment
    private func showLoading(isLoading: Bool) {
        
        if isLoading {
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
            
            view.layoutIfNeeded()
        } else {
            activityIndicator.removeFromSuperview()
        }
    }
    
    /// Show alert controller with error
    /// - parameter: error: Description of the error
    private func showError(error: String) {
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: error, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Binding ViewModel -

extension PeopleListViewController {

    private func setupViewModel() {
        
        /// Listener to reload data
        viewModel.reloadData = { [weak self] () -> Void in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.showAlert = { [weak self] (message) -> Void in
            DispatchQueue.main.async {
                self?.showError(error: message)
            }
        }
        
        viewModel.loadingStatus = { [weak self] (isLoading) -> Void in
            DispatchQueue.main.async {
                self?.showLoading(isLoading: isLoading)
            }
        }
        
        viewModel.fetchPeople()
    }
}

// MARK: - UITableViewDataSource -

extension PeopleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.cellId, for: indexPath) as? PersonCell else {
            fatalError("Cell not found")
        }
        
        cell.viewModel = viewModel.personViewModel(at: indexPath)
        
        return cell
    }
}
