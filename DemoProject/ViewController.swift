//
//  ViewController.swift
//  DemoProject
//
//  Created by Ruchin Somal on 13/09/17.
//  Copyright © 2017 Ruchin Somal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ctnDate: UICollectionView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblDateDetails: UITableView!
    
    var datesArr = [AnyObject]()
    var onceOnly = false
    var lastIndex = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDateArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDateArray() {
        var newDate = Date()
        for i in 0 ... 90 {
            let day = dateConvertor_NSDate(date: newDate as NSDate, format: "E")
            var tempDict:[String:AnyObject] = [:]
            tempDict["date"] = newDate as AnyObject
            tempDict["day"] = day as AnyObject
            tempDict["dayFirstLetter"] = String(describing: day.characters.first!) as AnyObject
            tempDict["isWed"] = false as AnyObject
            tempDict["isCurrentDate"] = false as AnyObject
            if i == 0 {
                tempDict["isCurrentDate"] = true as AnyObject
            }
            if day == "Wed" {
                tempDict["isWed"] = true as AnyObject
                datesArr.append(tempDict as AnyObject)
            } else {
                datesArr.append(tempDict as AnyObject)
            }
            newDate = Calendar.current.date(byAdding: .day, value: -1, to: newDate)!
        }
        datesArr = datesArr.reversed()
        lblDate.text = dateConvertor_NSDate(date: NSDate(), format: "EEEE, dd MMMM yyyy")
    }
    
    func dateSelected(button:UIButton) {
        //button.isSelected = !button.isSelected
        lblDate.text = dateConvertor_NSDate(date: datesArr[button.tag]["date"] as! NSDate, format: "EEEE, dd MMMM yyyy")
        
        var tempDict:[String:AnyObject] = [:]
        tempDict["date"] = datesArr[lastIndex]["date"] as AnyObject
        tempDict["day"] = datesArr[lastIndex]["day"] as AnyObject
        tempDict["dayFirstLetter"] = datesArr[lastIndex]["dayFirstLetter"] as AnyObject
        tempDict["isWed"] = datesArr[lastIndex]["isWed"] as AnyObject
        tempDict["isCurrentDate"] = false as AnyObject
        datesArr.remove(at: lastIndex)
        datesArr.insert(tempDict as AnyObject, at: lastIndex)
        
        tempDict.removeAll()
        tempDict["date"] = datesArr[button.tag]["date"] as AnyObject
        tempDict["day"] = datesArr[button.tag]["day"] as AnyObject
        tempDict["dayFirstLetter"] = datesArr[button.tag]["dayFirstLetter"] as AnyObject
        tempDict["isWed"] = datesArr[button.tag]["isWed"] as AnyObject
        tempDict["isCurrentDate"] = true as AnyObject
        datesArr.remove(at: button.tag)
        datesArr.insert(tempDict as AnyObject, at: button.tag)
        
        let index1 = IndexPath(item: lastIndex, section: 0)
        let index2 = IndexPath(item: button.tag, section: 0)
        ctnDate.reloadItems(at: [index1,index2])
        lastIndex = button.tag
    }
    
}
extension ViewController: UITableViewDelegate {
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.selectionStyle = .none
        roundedView(anyView: cell.vwBg, width: 5.0,mastkBound: false)
        roundedView(anyView: cell.vw1, width: 20.0,mastkBound: false)
        roundedView(anyView: cell.vw2, width: 20.0,mastkBound: false)
        roundedView(anyView: cell.img1, width: 20.0,mastkBound: true)
        addShadowOnViews(cell.vwBg)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
extension ViewController: UICollectionViewDelegate {
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as! MainCollectionCell
        collectionCell.lblDay.text = datesArr[indexPath.row]["dayFirstLetter"] as? String
        collectionCell.btnDate.tag = indexPath.row
        roundedView(anyView: collectionCell.btnDate, width: 16.0,mastkBound: true)
        collectionCell.btnDate.setTitle(dateConvertor_NSDate(date: datesArr[indexPath.row]["date"] as! NSDate, format: "dd"), for: .normal)
        collectionCell.btnDate.addTarget(self, action: #selector(self.dateSelected(button:)), for: .touchUpInside)
        let isWed = datesArr[indexPath.row]["isWed"] as! Bool
        let isCurrentDate = datesArr[indexPath.row]["isCurrentDate"] as! Bool
        if isWed {
            if isCurrentDate {
                collectionCell.btnDate.tintColor = hexStringToUIColor(hex: "#A020F0")
                collectionCell.btnDate.isSelected = true
                collectionCell.btnDate.backgroundColor = hexStringToUIColor(hex: "#A020F0")
            } else {
                collectionCell.btnDate.tintColor = hexStringToUIColor(hex: "#007AFF")
            collectionCell.btnDate.isSelected = true
            collectionCell.btnDate.backgroundColor = hexStringToUIColor(hex: "#007AFF")
            }
        } else {
            if isCurrentDate {
                collectionCell.btnDate.tintColor = hexStringToUIColor(hex: "#A020F0")
                collectionCell.btnDate.isSelected = true
                collectionCell.btnDate.backgroundColor = hexStringToUIColor(hex: "#A020F0")
            } else {
            collectionCell.btnDate.isSelected = false
            collectionCell.btnDate.backgroundColor = UIColor.white
            }
        }
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            let indexToScrollTo = IndexPath(item: datesArr.count - 1, section: 0)
            self.ctnDate.scrollToItem(at: indexToScrollTo, at: .right, animated: false)
            onceOnly = true
        }
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(self.view.bounds.size.width / 7.0) - 1.0 ,height:99.0)
    }
}

