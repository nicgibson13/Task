//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Nic Gibson on 6/19/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var delegate: ButtonTableViewCellDelegate?
    
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}
extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}
protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
    
}
