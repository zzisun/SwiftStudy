//
//  PersonTableViewCell.swift
//  PhoneBookApp
//
//  Created by κΉμ§μ  on 2021/11/02.
//

import UIKit

class PersonCell: UITableViewCell {
    static let id = "PersonCell"

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(person: Person) {
        self.avatarImageView.image = "π".image()
        self.fullNameLabel.text = "\(person.lastName) \(person.firstName)"
        self.phoneNumberLabel.text = person.phoneNumber
    }
}
