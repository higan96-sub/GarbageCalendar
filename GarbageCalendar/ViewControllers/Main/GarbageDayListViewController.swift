//
//  GarbagesViewController.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/19.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import DeckTransition
import GarbageCalendarModel
import GarbageCalendarPresenter
import DropDown

class GarbageDayListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var settingButton: UIBarButtonItem!
    
    
    private var days: [String] = []
    private var firstDate = Date.today()
    private var selectedGarbageDay: GarbageDay!
    private let dropDown = DropDown()
    private var presenter: GarbageDayListPresenter!
    private var reloadedAt: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GarbageDayListPresenter(view: self)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(cellTypes: [SingleGarbageCell.self, DoubleGarbageCell.self, QuattroGarbageCell.self])
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 6))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40 + 4))
        
        title = "todays_garbage".localized
        (parent as? UINavigationController)?.navigationBar.shadowImage = UIImage()
        
        initDropDown()
        
        NotificationCenter.default.addObserver(self, selector: #selector(type(of: self).didGarbageImageViewTouched(notification:)), name: .GarbageImageViewDidTouch, object: GarbageDayListViewController.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = true
        reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.showWalkthrough()
        super.viewDidAppear(animated)
    }
    
    @IBAction func didCalendarButtonTapped(_ sender: UIBarButtonItem) {
        presentModal("Calendar")
    }
    
    @IBAction func didSettingButtonTapped(_ sender: Any) {
        dropDown.show()
    }
    
    public func reload() {
        if presenter.isListReloadable(reloadedAt) {
            firstDate = Date.today()
            presenter.getGarbageDays(from: firstDate, forDays: 7)
            tableView.reloadData()
            reloadedAt = Date.today()
            return
        }
    }
    
    private func initDropDown() {
        dropDown.dataSource = SettingMenu.labels().map({ (label) -> String in
            label
        })
        if let height = self.navigationController?.navigationBar.bounds.size.height {
            dropDown.bottomOffset = CGPoint(x: 0, y: height / 2)
        }
        dropDown.anchorView = settingButton
        dropDown.width = view.bounds.width
        dropDown.cellNib = UINib(nibName: "MenuCell", bundle: nil)
        reloadMenu()
        dropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            let menuItemKind = SettingMenu.items[index]
            self.presenter.doMenuAction(kind: menuItemKind)
            self.dropDown.clearSelection()
        }
    }
    
    @objc private func didGarbageImageViewTouched(notification: Notification) {
        guard let categoryId = notification.userInfo?[GarbageImageView.UserInfoKey] as? Int else { return }
        print(categoryId)
        if navigationController?.visibleViewController is GarbageDayListViewController {
            return self.presentModal("GarbageDay")
        }
        dismiss(animated: true) {
            self.presentModal("GarbageDay")
        }
    }
}

extension GarbageDayListViewController: GarbageDayListView {
    func presentWalkthrough() {
        let vc = StartSettingViewController.instantiate(withStoryboard: "Walkthrough")
        present(vc, animated: false, completion: nil)
    }
    
    func reloadMenu() {
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MenuCell else { return }
            let kind = SettingMenu.items[index]
            cell.suffixLabel.text = self.presenter.getSettingValue(for: kind)
            cell.accessoryType = .disclosureIndicator
        }
    }
    
    func transitionToRegionSetting(){
        let sb = UIStoryboard(name: "RegionSetting", bundle: Bundle.main)
        guard let modal = sb.instantiateInitialViewController() else { return }
        navigationController?.pushViewController(modal, animated: true)
    }
    
    func transitionToAlarmSetting(){
        let sb = UIStoryboard(name: "AlarmSetting", bundle: Bundle.main)
        guard let modal = sb.instantiateInitialViewController() else { return }
        navigationController?.pushViewController(modal, animated: true)
    }
    
    func transitionToAbout(){
        print("transitionToAbout")
    }
}

extension GarbageDayListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as? UITableViewHeaderFooterView
        headerView?.tintColor = .white
        headerView?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        if section == 0 {
            headerView?.textLabel?.textColor = .main
        } else {
            headerView?.textLabel?.textColor = .darkGray
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getGarbageDaysCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let dateString = presenter.getDateString(fromDate: firstDate, toDay: section) else { return nil }
        switch section {
        case 0:
            return dateString
        case 1:
            return "tommorow".localized + " - " + dateString
        case 7:
            return "next_week".localized + " - " + dateString
        default:
            return String(section) + "days_later".localized +  " - " + dateString
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.getGarbageCategories(index: indexPath.section).count {
        case 2:
            return cellFor(DoubleGarbageCell.self, tableView: tableView, indexPath: indexPath)
        case 3...99999 :
            return cellFor(QuattroGarbageCell.self, tableView: tableView, indexPath: indexPath)
        default:
            return cellFor(SingleGarbageCell.self, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.presentModal("GarbageDay")
        }
    }
}

extension GarbageDayListViewController {
    private func cellFor<CellType: GarbageCell>(_ type: CellType.Type, tableView: UITableView, indexPath: IndexPath) -> CellType {
        let cell = tableView.dequeueReusableCell(with: type, for: indexPath)
        let isToday = indexPath.section == 0
        cell.setGarbageDay(presenter.getGarbageDay(index: indexPath.section))
        cell.setColor(isToday: isToday)
        return cell
    }
    
    private func presentModal(_ storyboardName: String) {
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        if let modal = sb.instantiateInitialViewController() {
            let transitionDelegate = DeckTransitioningDelegate()
            modal.transitioningDelegate = transitionDelegate
            modal.modalPresentationStyle = .custom
            present(modal, animated: true, completion: nil)
        }
    }
}
