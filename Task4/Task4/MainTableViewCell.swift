//
//  MainTableViewCell.swift
//  Task4
//
//  Created by Егор Зайнуллин on 02.02.2022.
//

import UIKit
import RealmSwift

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private let realm = try! Realm()
    
    @IBAction func makeDone(_ sender: Any)
    {
        try! realm.write {
            element?.isDone = true
        }
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        try! realm.write {
        element?.isDeleted = true
        }
    }
    
    @IBOutlet weak var desriptionLabel: UILabel!
    
    @IBOutlet weak var dateOfCreationLabel: UILabel!
    
    @IBOutlet weak var dateToDoLabel: UILabel!
    
    var element: ToDoElement?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
