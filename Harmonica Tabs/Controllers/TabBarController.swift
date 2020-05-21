//
//  TabBarController.swift
//  Harmonica Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.flatRed()
        tabBar.unselectedItemTintColor = UIColor.flatGreenDark()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setTabbar()
        loadUserDefault()
    }
    
    func setTabbar() {
        let listVC = ListTabsViewController()
        let listNav = UINavigationController(rootViewController: listVC)
        listVC.setupBar()
        
        let favoriteVC = FavoriteListViewController()
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteVC.setupBar()

        let settingVC = SettingViewController()
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingVC.setupBar()
        
        viewControllers = [listNav, favoriteNav, settingNav]
    }
    
    func loadUserDefault() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "First Run") != nil {
            print("Not First Launch")
        } else {
            defaults.set(true, forKey: "First Run")
            DispatchQueue.main.async{
                self.fetchData()
            }
        }
    }
    
    func fetchData() {
        print("First Launch and Fetch Data")
        if let path = Bundle.main.path(forResource: "list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObjs = try JSON(data: data)
                let realm = try! Realm()
                guard let Objects = jsonObjs.array else {return}
                for jsonObj in Objects {
                    if let songObject = getData(object: jsonObj) {
                        do {
                            try realm.write {
                                realm.add(songObject)
                            }
                        } catch let error {
                            print("Error \(error)")
                        }
                    }
                }
                print("All Done")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }


    func getData(object: JSON) -> Song? {
        let songObject = Song()
        
        let title = object["name"].stringValue
        
        // Check If Not Song
        if title == "" {
            return nil
        }
        
        // Set Title
        songObject.title = title.capitalized
        
        // Set ID
        let id = object["id"].intValue
        songObject.id = id
        
        // Set URL
        let url = object["original_url"].stringValue
        songObject.url = url
        
        // Set Thumbnail
        let thumbnail = object["thumb"].stringValue
        songObject.thumbImage = thumbnail
        if thumbnail == "" {
            songObject.thumbImage = "https://theharmonica.vn/wp-content/uploads/2019/11/Diatonic-Hohner-Special-20--640x480.jpg"
        }
        
        // Set Singer
        let singer = object["post_title"].stringValue
        var singerString = ""
        let singerArray = singer.components(separatedBy: " - ")
        if singerArray.count == 3 {
            singerString = singerArray[1].capitalized
        } else if singerArray.count == 2 && singerArray[1] != "Harmonica Tab"{
            singerString = singerArray[1].capitalized
        } else {
            singerString = object["singer"].stringValue.capitalized
        }
        singerString = singerString.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        songObject.singer = singerString
        songObject.composer = singerString
        
        // Set Date Time Interval
        let date = object["post_date"].stringValue
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateData = formatter.date(from: date)
        if let timeInterval = dateData?.timeIntervalSince1970 {
            songObject.date = timeInterval
        }
        
        // Set Level
        var level = object["level"].floatValue
        level = Float(round(level * 10)) / 10
        songObject.level = level
        
        // Set Lyric And Tab
        let lyric = object["lyric"].stringValue
        let tab = object["tab"].stringValue

        let lyricsAndTab = createLyricAndTab(lyric: lyric, tab: tab)
        songObject.lyricsAndTab.append(objectsIn: lyricsAndTab)
        
        print(songObject)
        return songObject
    }
    
    func createLyricAndTab(lyric: String, tab: String) -> [LyricAndTab] {
        var lyricsAndTabs = [LyricAndTab]()
        let lyricArray = lyric.components(separatedBy: "\n")
        let tabArray = tab.components(separatedBy: "\n")
        
        for (index, item) in lyricArray.enumerated() {
            let num = Int(item.replacingOccurrences(of: " ", with: ""))
            if num != nil {
                if num! <= tabArray.count {
                    let lyricAndTab = LyricAndTab()
                    
                    if index > 0 && Int(lyricArray[index - 1]) == nil {
                        lyricAndTab.lyric = lyricArray[index - 1].trimmingCharacters(in: .whitespacesAndNewlines).capitalized
                    }
                    var tab = tabArray[num!-1]
                    let lineString = tab.components(separatedBy: " ").first!
                    tab = String(tab.dropFirst(lineString.count + 1))
                    lyricAndTab.tab = formatString(text: tab)
                    
                    let lineS = lineString.filter("0123456789.".contains)
                    let lineNumber = Int(lineS)
                    if lineNumber != nil {
                        lyricAndTab.line = lineNumber!
                    }
                    lyricsAndTabs.append(lyricAndTab)
                }
            }
            else {
            }
        }
        return lyricsAndTabs
    }
    
    func formatString(text: String) -> String {
        let validChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890,-_#")
        var filteredString = text.filter {validChars.contains($0)}
        filteredString = filteredString.replacingOccurrences(of: ",", with: " , ")
        filteredString = filteredString.replacingOccurrences(of: "_", with: " _ ")
        filteredString = filteredString.replacingOccurrences(of: "-", with: " - ")
        let components = filteredString.components(separatedBy: .whitespacesAndNewlines)
        filteredString = components.filter { !$0.isEmpty }.joined(separator: " ")
        filteredString = filteredString.trimmingCharacters(in: .whitespacesAndNewlines)
        return filteredString
    }
}
