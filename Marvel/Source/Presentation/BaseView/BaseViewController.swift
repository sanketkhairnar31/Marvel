//
//  BaseViewController.swift
//  Marvel
//
//  Created by Sanket Khairnar on 04/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSpinner()
    }

    func showErrorMessage(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        self.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "button_title_Ok".localizedString(), style: .cancel, handler: {_ in
            alert.dismiss(animated: true)
        }))
    }

    func showSpinner() {
        spinner.startAnimating()
        spinner.isHidden = false
    }

    func hideSpinner() {
        spinner.stopAnimating()
    }
}

private extension BaseViewController {
    func setUpSpinner() {
        spinner.color = .gray
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.isHidden = true
    }
}
