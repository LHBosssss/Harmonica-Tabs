//
//  LyricTabCell.swift
//  Harmonica Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import RealmSwift

class LyricTabCell: UITableViewCell {
    
    var lyricsObject: LyricAndTab? {
        didSet {
            guard let lyrics = lyricsObject else { return }
            lyricText.text = lyrics.lyric
            tabText.text = lyrics.tab
        }
    }
        
    private let lyricText: UITextView = {
        let lyric = UITextView()
        lyric.textAlignment = .justified
        lyric.isScrollEnabled = false
        lyric.translatesAutoresizingMaskIntoConstraints = false
        lyric.font = UIFont.systemFont(ofSize: 16)
        lyric.backgroundColor = UIColor.clear
        lyric.textColor = UIColor.black
        lyric.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return lyric
    }()
    
    private let tabText: UITextView = {
        let tab = UITextView()
        tab.textAlignment = .justified
        tab.isScrollEnabled = false
        tab.translatesAutoresizingMaskIntoConstraints = false
        tab.font = UIFont.systemFont(ofSize: 16)
        tab.backgroundColor = UIColor.clear
        tab.textColor = UIColor.black
        tab.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        return tab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        addSubview(lyricText)
        addSubview(tabText)
        NSLayoutConstraint.activate([
            lyricText.topAnchor.constraint(equalTo: self.topAnchor),
            lyricText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lyricText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            tabText.topAnchor.constraint(equalTo: lyricText.bottomAnchor),
            tabText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tabText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tabText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
