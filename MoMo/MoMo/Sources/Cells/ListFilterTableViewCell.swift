//
//  ListFilterTableViewCell.swift
//  MoMo
//
//  Created by 이정엽 on 2021/01/05.
//

import UIKit

class ListFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var listFilterTableViewCellHeight: NSLayoutConstraint!
    @IBOutlet weak var filterCollectionViewBottom: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

