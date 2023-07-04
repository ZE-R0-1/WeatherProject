//
//  SummaryTableViewCell.swift
//  WeatherPro
//
//  Created by 윤준영 on 2023/07/03.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let identifier = "SummaryTableViewCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var currentTempertureLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        statusLabel.textColor = .white
        minMaxLabel.textColor = statusLabel.textColor
        currentTempertureLabel.textColor = statusLabel.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
