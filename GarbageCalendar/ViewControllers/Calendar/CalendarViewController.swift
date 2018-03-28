//
//  CalendarViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/02/21.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel
import GarbageCalendarPresenter
import Timepiece
import DropDown

class CalendarViewController: UIViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    private var garbageDayDictionary = [[GarbageDay]]()
    private let today = Date.today()
    private var firstDate: Date!
    private var cellWidth: CGFloat!
    private let horizontalMargin: CGFloat = 8.0
    private let dropDown = DropDown()
    private var monthes = [Date]()
    private var presenter: CalendarPresenter!
    private var arrowIcon: UIImageView!
    private var surplus: CGFloat = 0.0
    private var calendarMonth: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDate = Date(year: today.year, month: today.month, day: 1)
        calendarMonth = today.month
        presenter = CalendarPresenter(self)
        presenter.getGarbageCalnderData(month: Date.today())
        presenter.getCalendarMenuItems()
        initDropBox()
        
        cellWidth = floor(view.bounds.width / 7)
        surplus = view.bounds.width - cellWidth * 7
        
        collectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        collectionView.register(UINib(nibName: "CalendarHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CalendarHeaderView")
        collectionView.register(CollectionBorderHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionBorderHeaderView")
    }
    
    override func viewDidAppear(_ animated: Bool) {        
        super.viewDidAppear(animated)
    }
    
    @IBAction func didCloseButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didEditButtonTapped(_ sender: Any) {
        dropDown.show()
    }
    
    private func initDropBox() {
        dropDown.anchorView = editButton
        dropDown.width = view.bounds.width
        dropDown.bottomOffset = CGPoint(x: 0, y: navigationController!.navigationBar.bounds.height / 2)
        dropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.presenter.getGarbageCalnderData(month: self.monthes[index])
        }
    }
}

extension CalendarViewController: CalendarView {
    func setGarbageDayDictionary(_ garbageDayDictionary: [[GarbageDay]], yearMonth: String, month: Int) {
        self.garbageDayDictionary = garbageDayDictionary
        self.calendarMonth = month
        title = yearMonth
        collectionView.reloadData()
    }
    
    func setCalenadarMenu(labels: [String], monthes: [Date], selectedRow: Int?) {
        self.monthes = monthes
        dropDown.dataSource = labels
        dropDown.selectRow(at: selectedRow)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return garbageDayDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        let garbageDay = garbageDayDictionary[indexPath.section][indexPath.row]
        let isToday = garbageDay.date == today
        let isWeekday = 1 < garbageDay.date.weekday && garbageDay.date.weekday < 7
        
        cell.setDateLabelText(garbageDay.date.day)
        cell.setIconImage(imageName: garbageDay.smallImageName())
        cell.changeDateLabelFont(isToday: isToday)
        cell.changeBorderColor(isToday: isToday)
        cell.changeDayLabelColor(isToday: isToday, isWeekday: isWeekday)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: CalendarCollectionViewCell.Height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section != 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionBorderHeaderView", for: indexPath)
            return header
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CalendarHeaderView", for: indexPath) as! CalendarHeaderView
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: surplus)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section != 0 {
            return CGSize(width: self.view.bounds.width, height: 1)
        }
        return CGSize(width: view.bounds.width - horizontalMargin * 2 - 32, height: CalendarHeaderView.Height)
    }
}
