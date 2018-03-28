//
//  GarbageViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/07.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import PagingMenuController

class GarbageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var labelStrings = [[String]]()
    private var titleStrings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: LabelCell.self)
        titleStrings = [
            "収集時間",
            "収集方法",
            "出し方",
            "主な種類",
            "出し方の注意",
            "出せないもの"
        ]
        labelStrings = [
            ["朝8時"],
            ["戸別回収"],
            ["バケツ等の容器"],
            ["食品用", "飲料用", "酒類", "菓子類", "スプレー缶", "卓上ガスボンベ", "その他食品の缶"],
            ["中身を出して水で軽くゆすいでください。","カンはつぶさないで出してください。つぶしてしまうとカン同士がかみ合ってうまく選別ができなくなります。", "カンの中に異物を入れないでください。", "卓上ガスボンベ・スプレー缶は穴をあけて出してください。穴を開けられない場合は特定処理品目として出してください。"],
            ["18リットルカン・塗料カン（中身を出し、上ぶた等を切り取るなどして不燃ごみ）", "50cm以上のカン（衣装カン等は大型ごみ）", "アルミボトルのふた（不燃ごみ）", "ホーロー製の鍋・さび・焦げ付き等汚れのひどいもの（不燃ごみ）", "ハンガー・針金・釘・その他金属類（不燃ごみ）", "包丁・はさみ（厚紙などで包んで不燃ごみ）"]
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension GarbageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: LabelCell.self, for: indexPath)
        let labels = labelStrings[indexPath.section]
        if labels.count <= 1 {
            cell.label.text = labels.first
            return cell
        }
        cell.label.attributedText = NSAttributedString.list(stringList: labels, font: UIFont.systemFont(ofSize: 17.0))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return labelStrings.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleStrings[section]
    }
}
