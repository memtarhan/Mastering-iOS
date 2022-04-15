//
//  ContactCell.swift
//  ContactList
//
//  Created by Mehmet Tarhan on 15/04/2022.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
