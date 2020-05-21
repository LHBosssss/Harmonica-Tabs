//
//  Tab.swift
//  Harp Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import RealmSwift

class Song: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var thumbImage: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var singer: String = ""
    @objc dynamic var composer: String = ""
    @objc dynamic var date: TimeInterval = TimeInterval(0)
    @objc dynamic var level: Float = 0
    @objc dynamic var isFavorite: Bool = false
    let lyricsAndTab = List<LyricAndTab>()
}
