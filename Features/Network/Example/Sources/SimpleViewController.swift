//
//  SimpleViewController.swift
//  NetworkKitExample
//
//  Created by Ronan O Ciosig on 2/5/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import UIKit
import NetworkKit
import Common

class SimpleViewController: UIViewController {
    var dataProvider: DataProvider
    
    var label: UILabel!
    var textField: UITextField!
    var searchButton: UIButton!
    
    let sideMargin: CGFloat = 20.0
    let textFieldHeight: CGFloat = 40.0
    let buttonHeight: CGFloat = 44.0
    let labelHeight: CGFloat = 25.0
    let spacing: CGFloat = 30.0
    let topMargin: CGFloat = 120
    
    let networkService: SearchService
    
    init(dataProvider: DataProvider, networkService: SearchService) {
        self.dataProvider = dataProvider
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
        self.dataProvider.notifier = self
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        title = Constants.Translations.SimpleView.title
        
        addLabel()
        addTextField()
        addButton()
    }
    
    func addLabel() {
        label = UILabel(frame: CGRect.zero)
        label.text = Constants.Translations.SimpleView.labelText
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargin),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargin),
            label.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
    
    func addTextField() {
        textField = UITextField(frame: CGRect.zero)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin + spacing + labelHeight),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargin),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        
        textField.placeholder = Constants.Translations.SimpleView.placeholder
    }
    
    func addButton() {
        searchButton = UIButton(type: .roundedRect)
        searchButton.setTitle(Constants.Translations.SimpleView.Button.search, for: .normal)
        searchButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin + labelHeight + spacing + textFieldHeight + spacing),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargin),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargin),
            searchButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc func buttonAction() {
        let text = textField.text ?? ""
        
        if !text.isEmpty, let identifier = Int(text) {
            
            if identifier > Constants.PokemonAPI.maxIdentifier {
                showError(message: Constants.Translations.SimpleView.Alert.Error.outOfRange)
                return
            }
            
            dataProvider.search(identifier: identifier, networkService: networkService)
            
            textField.resignFirstResponder()
            textField.text = ""
        } else {
            showError(message: Constants.Translations.SimpleView.Alert.Error.enterVlidNumber)
            textField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimpleViewController {
    
    func showPokemonFoundAlert(name: String) {
        let alertController = alert(with: Constants.Translations.SimpleView.Alert.found + name)
        let button = leaveButton(with: Constants.Translations.ok)
        
        alertController.addAction(button)
        present(alertController,
                               animated: true,
                               completion: nil)
    }

    func showError(message: String) {
        let alertController: UIAlertController
        
        if message == "404" {
            alertController = alert(with: "Error: Not Found")
        } else {
            alertController = alert(with: "Error: \(message)")
        }
        
        let okButton = leaveButton(with: Constants.Translations.ok)
        
        alertController.addAction(okButton)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    private func alert(with title: String) -> UIAlertController {
        return UIAlertController(title: title,
                                 message: nil,
                                 preferredStyle: .alert)
    }
    
    private func leaveButton(with title: String) -> UIAlertAction {
        return UIAlertAction(title: title,
                             style: .default, handler: nil)
    }
}

extension SimpleViewController: Notifier {
    func dataReceived(errorMessage: String?, on queue: DispatchQueue?) {
        DispatchQueue.main.async {
            if let message = errorMessage {
                self.showError(message: message)
            } else {
                self.showPokemonFoundAlert(name: self.dataProvider.pokemonName() ?? Constants.Translations.SimpleView.Alert.Error.nameNotFound)
            }
        }
    }
}
