//
//  ViewController.swift
//  Associative_Reference_Test
//
//  Created by Obinna Aguwa on 23/01/2024.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - Enums
    
    // Static variable to serve as the key for association
    enum AssociatedKey {
        static var key: Int = 0
    }
    
    // MARK: - Properties
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Private Methods

extension ViewController {
    
    func setupUI() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func onButtonTapped() {
        // create the alert and the payload
        let alert = UIAlertController(title: "Title", message: "Example message", preferredStyle: .alert)
        let payload = "Example message"
        // Associate the payload with the alert using the objc_setAssociatedObject function
        objc_setAssociatedObject(self, &AssociatedKey.key, payload, .OBJC_ASSOCIATION_RETAIN)
        // Add an OK button to the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.handleAlertDismissed()
        }
        alert.addAction(okAction)
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    func handleAlertDismissed() {
        // Retrieve the associated payload using objc_getAssociatedObject
        if let payload = objc_getAssociatedObject(self, &AssociatedKey.key) {
            // Log the payload
            print("Payload is: \(payload)")
        }
    }
}
