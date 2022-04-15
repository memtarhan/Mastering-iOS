//
//  ViewController.swift
//  ContactList
//
//  Created by Mehmet Tarhan on 15/04/2022.
//

import Contacts
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()

        requestContacts()
    }

    private func requestContacts() {
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)

        if authorizationStatus == .notDetermined {
            store.requestAccess(for: .contacts) { [weak self] authorized, _ in
                if authorized {
                    self?.retrieveContacts(from: store)
                }
            }

        } else if authorizationStatus == .authorized {
            retrieveContacts(from: store)
        }
    }

    private func retrieveContacts(from store: CNContactStore) {
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                           CNContactFamilyNameKey as CNKeyDescriptor,
                           CNContactImageDataAvailableKey as CNKeyDescriptor,
                           CNContactImageDataKey as CNKeyDescriptor]

        contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact") as! ContactCell

        let contact = contacts[indexPath.row]

        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"

        if let imageData = contact.imageData {
            cell.contactImageView.image = UIImage(data: imageData)

        } else {
            cell.contactImageView.image = UIImage(systemName: "person.circle")
        }

        return cell
    }
}
