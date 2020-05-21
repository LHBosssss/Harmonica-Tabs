//
//  LyricsAndTab.swift
//  Harp Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import RealmSwift

class LyricAndTab: Object {
    @objc dynamic var line: Int = 0
    @objc dynamic var lyric: String = ""
    @objc dynamic var tab: String = ""
}
