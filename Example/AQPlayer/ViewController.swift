//
//  ViewController.swift
//  PlayerDemo
//
//  Created by Ahmad Amri on 2/28/19.
//  Copyright © 2019 Amri. All rights reserved.
//

import UIKit
import AQPlayer

class ViewController: UIViewController {
    
    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var playPuseButton: UIButton!
    @IBOutlet var fwButton: UIButton!
    @IBOutlet var bwButton: UIButton!
    
    @IBOutlet var listTitleLabel: UILabel!
    
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var partLabel: UILabel!
    
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    @IBOutlet var playRateButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    let playerManager = AQPlayerManager.shared
    var playeritems: [AQPlayerItemInfo] = []
    var remoteControlMode: AQRemoteControlMode = .skip
    
    var parts: [[String]] = [[""]]
    
    func loadSampleData() {
        
        let title = "The Secret Garden"
        let albumTitle = "Novel"
        let coverImgUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Houghton_AC85_B9345_911s_-_Secret_Garden%2C_1911_-_cover.jpg/402px-Houghton_AC85_B9345_911s_-_Secret_Garden%2C_1911_-_cover.jpg"
        
        // chapter title , audio file
       parts = [["There is No One Left","secretgarden_01_burnett_64kb.mp3"],
                     ["Mistress Mary Quite Contrary","secretgarden_02_burnett_64kb.mp3"],
                     ["Across the Moor","secretgarden_03_burnett_64kb.mp3"],
                     ["Martha","secretgarden_04_burnett_64kb.mp3"],
                     ["The Cry in The Corridor","secretgarden_05_burnett_64kb.mp3"],
                     ["There Was Someone Crying - There Was!","secretgarden_06_burnett_64kb.mp3"],
                     ["The Key to the Garden","secretgarden_07_burnett_64kb.mp3"],
                     ["The Robin Who Showed the Way","secretgarden_08_burnett_64kb.mp3"],
                     ["The Strangest House Any One Ever Lived In","secretgarden_09_burnett_64kb.mp3"],
                     ["Dickon","secretgarden_10_burnett_64kb.mp3"],
                     ["The Nest of the Missel Thrush","secretgarden_11_burnett_64kb.mp3"],
                     ["Might I Have a Bit of Earth?","secretgarden_12_burnett_64kb.mp3"],
                     ["I am Colin","secretgarden_13_burnett_64kb.mp3"],
                     ["A Young Rajah","secretgarden_14_burnett_64kb.mp3"],
                     ["Nest Building","secretgarden_15_burnett_64kb.mp3"],
                     ["I Won't! Said Mary","secretgarden_16_burnett_64kb.mp3"],
                     ["A Tantrum","secretgarden_17_burnett_64kb.mp3"],
                     ["Tha' Munnot Waste No Time","secretgarden_18_burnett_64kb.mp3"],
                     ["It Has Come","secretgarden_19_burnett_64kb.mp3"],
                     ["I Shall Live Forever - and Ever - and Ever!","secretgarden_20_burnett_64kb.mp3"],
                     ["Ben Weatherstaff","secretgarden_21_burnett_64kb.mp3"],
                     ["When the Sun Went Down","secretgarden_22_burnett_64kb.mp3"],
                     ["Magic","secretgarden_23_burnett_64kb.mp3"],
                     ["Let Them Laugh","secretgarden_24_burnett_64kb.mp3"],
                     ["The Curtain","secretgarden_25_burnett_64kb.mp3"],
                     ["It's Mother!","secretgarden_26_burnett_64kb.mp3"],
                     ["In the Garden","secretgarden_27_burnett_64kb.mp3"]]
        
        for i in 0..<parts.count {
            if let url = URL(string: "https://ia600500.us.archive.org/0/items/secret_garden_1105_librivox/\(parts[i][1])") {
                let item = AQPlayerItemInfo(id: i,
                                            url: url,
                                            title: "\(title) \(i+1)/\(parts.count) - \(parts[i][0])",
                                            albumTitle: albumTitle,
                                            coverImageURL: nil,
                                            startAt: 0)
                playeritems.append(item)
            }
        }
        
        // set cover image
        if let url = URL(string:coverImgUrl)
        {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        self.albumImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        
        
        self.listTitleLabel.text = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup chaptes list
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        
        // UI setup
        self.bwButton.subviews.first?.contentMode = .scaleAspectFit
        self.fwButton.subviews.first?.contentMode = .scaleAspectFit
        self.playRateButton.layer.cornerRadius = 5.0
        
        loadSampleData()
        
        // setup player manager
        playerManager.delegate = self
        playerManager.setup(with: playeritems, startFrom: 0, playAfterSetup: false)
        
        let interval = 20.0
        playerManager.skipIntervalInSeconds = 20.0
        self.fwButton.setTitle("\(Int(interval))", for: .normal)
        self.bwButton.setTitle("\(Int(interval))", for: .normal)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(changeRemoteCotrolMode))
        albumImage.addGestureRecognizer(imageTap)
    }
    
    @objc func changeRemoteCotrolMode() {
        self.remoteControlMode = self.remoteControlMode == .skip ? .nextprev : .skip
        playerManager.setCommandCenterMode(mode: self.remoteControlMode)
    }
    
    @IBAction func fwAction(_ sender: Any) {
        self.animateButton(sender)
        
        playerManager.skipForward()
    }
    @IBAction func bwAction(_ sender: Any) {
        self.animateButton(sender)
        playerManager.skipBackward()
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
        self.animateButton(sender)
        
        let status = playerManager.playOrPause()
        setPlayPauseButtonImage(status)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.animateButton(sender)
        
        playerManager.next()
    }
    @IBAction func prevAction(_ sender: Any) {
        self.animateButton(sender)
        
        playerManager.previous()
    }
    
    @IBAction func slideFinish(_ sender: Any) {
        self.progressSlider.isEnabled = false
        playerManager.seek(toPercent: Double(self.progressSlider.value))
        self.progressSlider.isEnabled = true
    }
    @IBAction func didSlide(_ sender: Any) {
        self.timeLabel.text = self.stringFromTimeInterval(interval: TimeInterval(self.progressSlider.value * Float(playerManager.duration)))
    }
    
    @IBAction func changeRateAction(_ sender: Any) {
        let newRate = playerManager.changeToNextRate()
        self.playRateButton.setTitle("\(newRate)x", for: .normal)
    }
    
    func rotateView(_ targetView: UIView, duration: Double = 3.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .infinity
        
        targetView.layer.add(rotateAnimation, forKey: nil)
    }
    
    // MARK: helpers
    fileprivate func setPlayPauseButtonImage(_ status: AQPlayerStatus) {
        self.playPuseButton.layer.removeAllAnimations()
        switch status {
        case .loading, .none:
            self.playPuseButton.setBackgroundImage(UIImage(named: "loading"), for: .normal)
            self.rotateView(self.playPuseButton)
        case .readyToPlay, .paused:
            self.playPuseButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
            
        case .playing:
            self.playPuseButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            
        case .failed:
            self.playPuseButton.setBackgroundImage(UIImage(named: "error"), for: .normal)
        }
    }
    private func animateButton(_ sender: Any) {
        guard let view = sender as? UIView else {
            return
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            view.tintColor = .white
        }) { (done) in
            view.tintColor = .black
        }
        
    }
    private func stringFromTimeInterval(interval: TimeInterval) -> String {
        if interval.isNaN {
            return ""
        }
        
        let ti = NSInteger(interval)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if hours > 0 {
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        } else {
            return String(format: "%0.2d:%0.2d",minutes,seconds)
        }
    }
    
}

extension ViewController: AQPlayerDelegate {
    
    func getCoverImage(_ player: AQPlayerManager, _ callBack: @escaping (UIImage?) -> Void) {
        print("get cover image")
        callBack(self.albumImage.image)
    }
    
    func aQPlayerManager(_ playerManager: AQPlayerManager, statusDidChange status: AQPlayerStatus) {
        print("statusDidChange")
        self.setPlayPauseButtonImage(status)
    }
    
    func aQPlayerManager(_ playerManager: AQPlayerManager, itemDidChange itemIndex: Int) {
        print("itemDidChange")
        partLabel.text = "\(itemIndex + 1) / \(self.playeritems.count)"
        self.prevButton.isEnabled = itemIndex > 0
        self.nextButton.isEnabled = itemIndex < self.playeritems.count - 1
        
        // // select cell in tableview
        guard itemIndex >= 0 else {
            if let index = self.tableView.indexPathForSelectedRow{
                self.tableView.deselectRow(at: index, animated: true)
            }
            return
        }
        let index = IndexPath(row: itemIndex, section: 0)
        self.tableView.selectRow(at: index, animated: true, scrollPosition: .top)
    }
    
    func aQPlayerManager(_ playerManager: AQPlayerManager, progressDidUpdate percentage: Double) {
        print("progressDidUpdate")
        guard self.progressSlider.isEnabled && !self.progressSlider.isTracking else {
            return
        }
        
        self.progressSlider.setValue(Float(percentage), animated: true)
        
        self.timeLabel.text = self.stringFromTimeInterval(interval: playerManager.currentTime)
        self.remainingLabel.text = self.stringFromTimeInterval(interval:(playerManager.duration - playerManager.currentTime))
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playeritems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Cahpter \(indexPath.row + 1): \(self.parts[indexPath.row][0])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerManager.goTo(indexPath.row)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
