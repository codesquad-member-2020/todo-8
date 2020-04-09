//
//  TodoCell.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    static let reuseIdentifier = "TodoCell"
    
    private var viewModel: Card? {
        didSet {
            self.titleLabel.text = viewModel?.title
            self.contentLabel.text = viewModel?.contents
            self.authorLabel.text = "author by \(viewModel?.author ?? "unknown")"
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with card: Card?) {
        guard viewModel != card else { return }
        viewModel = card
    }
}
