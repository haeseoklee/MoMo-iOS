//
//  BubbleTableViewCell.swift
//  MoMo
//
//  Created by 초이 on 2021/01/10.
//

import UIKit

class BubbleTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var bubbleSize: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeading: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var bubble: [Bubble] = []
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    func setCell(bubble: Bubble) {
        dateLabel.text = bubble.date
        emotionLabel.text = bubble.cate
        bubbleLeading.constant = calculateLeadingOffset(num: bubble.leadingNum)
    }
    
    func calculateLeadingOffset(num: Int) -> CGFloat {
        if num == -1 {
            bubbleView.isHidden = true
        } else {
            bubbleView.isHidden = false
        }
        
        let viewWidth = UIScreen.main.bounds.width - 32 - bubbleSize.constant
        let leadingOffset = CGFloat(Int(viewWidth) / 10 * num + 32)
        
        return leadingOffset
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
