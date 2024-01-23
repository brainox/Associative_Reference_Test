//
//  ViewController.swift
//  Associative_Reference_Test
//
//  Created by Obinna Aguwa on 23/01/2024.
//

import UIKit


// Static variable to serve as the key for association
private var key: UInt8 = 0

class ViewController: UIViewController, UIAlertViewDelegate {
    
    let alert = UIAlertController(title: "Dummy title", message: "Dummy message", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onAlertTapped(_ sender: UIButton) {
        let payload = UIViewController()

        // Associate the payload with the alert using the objc_setAssociatedObject function
        objc_setAssociatedObject(alert, &key, payload, .OBJC_ASSOCIATION_RETAIN)

        // Add an OK button to the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.handleAlertDismissed()
        }
        alert.addAction(okAction)

        // Present the alert
        present(alert, animated: true, completion: nil)
    }

    private func handleAlertDismissed() {
        // Retrieve the associated payload using objc_getAssociatedObject
        if let payload = objc_getAssociatedObject(alert, &key) {
            // Log the payload
            print("Payload was: \(payload)")
        }
    }
}
