//
//  ViewController.swift
//  AutoSuggestTextFiled
//
//  Created by Optisol on 23/05/18.
//  Copyright © 2018 Optisol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var autoCompleteText:UITextField!
    var countriesArray:[String] = Array()
    var searchedArray:[String] = Array()
    
    let autoSuggestView: UIView = UIView ()
    let autoSuggestTableView: UITableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        countriesArray.append("India")
        countriesArray.append("Australia")
        countriesArray.append("New Zealand")
        countriesArray.append("France")
        countriesArray.append("United Kingdom")
        countriesArray.append("Belarus")
        countriesArray.append("Canada")
        countriesArray.append("USA")
        countriesArray.append("Mexico")
        countriesArray.append("Argentina")
        countriesArray.append("Slovakia")
        searchedArray = countriesArray
        autoSuggestTableView.delegate =  self
        autoSuggestTableView.dataSource = self
        autoCompleteText.addTarget(self, action: #selector(searchRecordsAsPerText(_:)),for: .editingChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        autoCompleteText.layer.borderColor = UIColor.red.cgColor;

    }
    
    //MARK:- Autosuggest TableView
    
    func createTableView() {
        autoSuggestView.frame = CGRect(x:autoCompleteText.frame.origin.x,y:autoCompleteText.frame.origin.y+autoCompleteText.frame.size.height, width:autoCompleteText.frame.size.width,height: 350)
        self.view.addSubview(autoSuggestView)
        self.viewShadow(view: autoSuggestView)
        autoSuggestTableView.frame = CGRect(x: 0, y: 0, width: autoSuggestView.frame.size.width, height: 350)
        autoSuggestTableView.dataSource = self
        autoSuggestTableView.delegate = self
        autoSuggestTableView.tableFooterView = UIView()
        autoSuggestView.addSubview(autoSuggestTableView)
    }
  
    
    func viewShadow(view: UIView) {
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 5.0
    }


    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        self.createTableView()
        searchedArray.removeAll()
        if textfield.text?.count != 0 {
            for strCountry in countriesArray {
                let range = strCountry.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    searchedArray.append(strCountry)
                }
            }
        } else {
            autoSuggestView.removeFromSuperview()
//            searchedArray = countriesArray
        }
        autoSuggestTableView.reloadData()
    }
    
    
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Identifier")
        }
        cell?.textLabel?.text = searchedArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        autoCompleteText.text = searchedArray[indexPath.row]
        autoSuggestView.removeFromSuperview()
    }
    

    /*
 
     //        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", textField.text!)
     //        let array = (self.cityListArray as NSArray).filtered(using: searchPredicate)
     //        filterCityListArray = array as! [String]
     //
     //        if filterCityListArray.count == 0 || textField.text == Constant().SEmpty{
     //            autoSuggestView.removeFromSuperview()
     //        }else {
     //            createTableView()
     //            autoSuggestTableView.reloadData()
     //        }

 
 */
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let currentText = textView.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        self.createTableView()
//        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
//        return changedText.count <= 1
//    }



}

