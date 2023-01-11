//
//  ViewController.swift
//  ContactApp
//
//  Created by Sanzhar Zhubatkhanov on 10.01.2023.
//

import UIKit

class ViewController: UIViewController, NewContactViewControllerDelegate {
    
    func didAddContact(contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
    
    
    private var tableView = UITableView()
    
    var contacts = [
        Contact(image: UIImage(named: "man"), name: "Sanzhar", phoneNumber: "87771588937", maleOrFemale: .male),
        Contact(image: UIImage(named: "man"), name: "Arnur", phoneNumber: "87771588937", maleOrFemale: .male),
        Contact(image: UIImage(named: "man"), name: "Nastya", phoneNumber: "87771588937", maleOrFemale: .female),
        Contact(image: UIImage(named: "man"), name: "Katya", phoneNumber: "87771588937", maleOrFemale: .female),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        title = "Contacts"
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let pushedVC = NewContactViewController()
        pushedVC.delegate = self
        navigationController?.pushViewController(pushedVC, animated: true)
    }
    
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        // guard let tableView = tableView else { return }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.config(info: contact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushedVC = ContactInfoViewController()
        pushedVC.contact = contacts[indexPath.row]
        pushedVC.didDeleteContact = { [weak self] contact in
            self?.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(pushedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

