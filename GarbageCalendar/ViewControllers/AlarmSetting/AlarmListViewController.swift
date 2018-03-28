
//
//  AlarmViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/08.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarPresenter
import UserNotifications
import DeckTransition

class AlarmListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: AlarmListPresenter!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "setting-menu-kind_alarm".localized
        
        presenter = AlarmListPresenter(self)
        modalPresentationCapturesStatusBarAppearance = true
        tableView.backgroundColor = .clear
        
        tableView.register(cellType: AlarmCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(!alarmSwitch.isOn, animated: false)
    }
    
    @IBAction func didCancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAllAlarmSettinSwitchTapped(_ sender: UISwitch) {
        navigationController?.setToolbarHidden(!sender.isOn, animated: true)
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        presenter.setAlarmSetting(isOn: sender.isOn)
    }
    
    @IBAction func didAddButtonTapped(_ sender: Any) {
        if !alarmSwitch.isOn { return }
        presentModal("AlarmEdit")
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

extension AlarmListViewController: AlarmListView {
    func reloadAlarmFlag(_ isOn: Bool) {
        alarmSwitch.setOn(isOn, animated: false)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AlarmCell.self, for: indexPath)
        let name = presenter.getGarbageDayTypeName(index: indexPath.row)
        let value = presenter.getAlarmValue(index: indexPath.row)
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = value
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getGarbageDayTypeCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentModal("AlarmEdit")
    }
}
