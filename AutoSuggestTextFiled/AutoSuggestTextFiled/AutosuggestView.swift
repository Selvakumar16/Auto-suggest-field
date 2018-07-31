//
//  AutosuggestView.swift
//  AutoSuggestTextFiled
//
//  Created by Optisol on 30/05/18.
//  Copyright © 2018 Optisol. All rights reserved.
//

/*
convenience override init() {
    self.init(fromString: "John")
}

init(fromString string: NSString) {
    self.someProperty = string
    super.init()
}
*/

import UIKit

class AutosuggestView: NSObject {
    
    let autoSuggestView: UIView = UIView ()
    let autoSuggestTableView: UITableView = UITableView()
    var searchArray = [String]()

    init(textField: UITextField,arrayList:[String]) {
        super.init()
        searchArray = arrayList
        autoSuggestView.frame = CGRect(x:textField.frame.origin.x,y:textField.frame.origin.y+60, width:textField.frame.size.width,height: 350)
        autoSuggestTableView.frame = CGRect(x: 0, y: 0, width: autoSuggestView.frame.size.width, height: 350)
        UIApplication.shared.keyWindow?.addSubview(autoSuggestTableView)
//        autoSuggestTableView.dataSource = self
//        autoSuggestTableView.delegate = self
        autoSuggestTableView.tableFooterView = UIView()
        autoSuggestView.addSubview(autoSuggestTableView)
        self.viewShadow(view: autoSuggestView)
    }
}

extension AutosuggestView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Identifier")
        }
        cell?.textLabel?.text = searchArray[indexPath.row]
        return cell!
    }
}

extension AutosuggestView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did Select")
    }
}

extension AutosuggestView {
    func viewShadow(view: UIView) {
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5.0
    }
}
