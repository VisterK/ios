//
//  NoteCell.swift
//  hw4
//
//  Created by Egor Kapustin on 07.10.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier: String = "NoteCell"
    let label: UILabel = UILabel()
    
    func configure(note: ShortNote) {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
    
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.textAlignment = .center
        label.text = note.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
}
