//
//  DoneTableViewCell.swift
//  Task4
//
//  Created by Егор Зайнуллин on 04.02.2022.
//

import UIKit
import RealmSwift

class DoneTableViewCell: UITableViewCell {

    var element: ToDoElement?
    
    private let realm = try! Realm()
    
    @IBAction func restore(_ sender: Any) {
        try! realm.write{
            element?.isDone = false
            element?.isDeleted = false
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateOfCreationLabel: UILabel!
    
    @IBOutlet weak var dateToDoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
