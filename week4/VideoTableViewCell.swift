//
//  VideoTableViewCell.swift
//  week4
//
//  Created by 장혜성 on 2023/08/09.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }

    private func designCell() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.numberOfLines = 2
        contentLabel.lineBreakMode = .byWordWrapping
        
        thumbnailImageView.contentMode = .scaleToFill
    }

}
