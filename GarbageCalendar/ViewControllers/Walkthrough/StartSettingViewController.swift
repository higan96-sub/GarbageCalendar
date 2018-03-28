//
//  StartSettingViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import DropDown
import GarbageCalendarPresenter
import GarbageCalendarModel

class StartSettingViewController: UIViewController {
    
    @IBOutlet weak var selectAreaButton: UIButton!
    @IBOutlet weak var selectRegionButton: UIButton!
    @IBOutlet weak var startButton: UIBarButtonItem!
    @IBOutlet weak var appIconBg: UIView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    private let regionDropDown = DropDown()
    private let areaDropDown = DropDown()
    private var presenter: StartSettingPresenter!
    
    private var selectedAreaName: String?
    private var selectedRegionName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StartSettingPresenter(self, municipalityId: 999999999)
        appIconBg.drawCorneredBorder(cornerRadius: 10, borderWidth: 2, borderColor: .accent)
        selectAreaButton.drawCorneredBorder()
        selectRegionButton.drawCorneredBorder(borderColor: .accent)
        areaDropDownInit()
        regionDropDownInit()
        presenter.getAreas()
        presenter.getRegions()
    }
    
    @IBAction func didSelectButtonTapped(_ sender: UIButton) {
        regionDropDown.show()
    }
    
    @IBAction func didAreaButtonTapped(_ sender: Any) {
        areaDropDown.show()
    }
    
    @IBAction func didStartButtonTapped(_ sender: UIBarButtonItem) {
        if let selectedRegionName = selectedRegionName {
            presenter.setMyRegion(selectedRegionName)
            return
        }
        self.selectRegionButton.layer.backgroundColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.3) {
            self.selectRegionButton.layer.backgroundColor = UIColor.accent.withAlphaComponent(0.3).cgColor
        }
    }
    
    private func areaDropDownInit() {
        areaDropDown.anchorView = selectAreaButton
        areaDropDown.bottomOffset = CGPoint(x: 0, y: selectAreaButton.bounds.height)
        areaDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.selectedAreaName = item
            self.selectAreaButton.setTitle(item, for: .normal)
            self.presenter.getRegions(for: item)
        }
    }
    
    private func regionDropDownInit() {
        regionDropDown.anchorView = selectRegionButton
        regionDropDown.bottomOffset = CGPoint(x: 0, y: selectRegionButton.bounds.height)
        regionDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.selectedRegionName = item
            self.selectRegionButton.setTitle(item, for: .normal)
            self.selectRegionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self.selectRegionButton.titleLabel?.font.pointSize)!)
            self.startButton.style = .done
            self.startButton.title = "start_app".localized
            self.selectRegionButton.layer.backgroundColor = UIColor.clear.cgColor
            self.bottomToolBar.alpha = 1.0
        }
    }
}

extension StartSettingViewController: StartSettingView {
    func setAreaLabels(labels: [String]) {
        areaDropDown.dataSource = labels
    }
    
    func setRegionLabels(labels: [String]) {
        regionDropDown.dataSource = labels
    }
    
    func setRegionTitle(title: String) {
        selectRegionButton.setTitle(title, for: .normal)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
