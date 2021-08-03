//
//  IJKPlayController.swift
//  Demo
//
//  Created by 金劲通 on 2021/4/9.
//

import UIKit
import SnapKit
import IJKMediaFramework




typealias DemoClosure = (Int)->()
class IJKPlayController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var playUrl: String?
    
    var isToolBarHidden = false
    
    var isAnimationCompleted = false

    var demoClosure:DemoClosure?
    
    var proFloatValue = 0.0
    
    override var hideNavigationBar: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        toolbarHide()
        print("\(playUrl ?? "")")


        //_ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(progressChanged(timer:)), userInfo: nil, repeats: true)
        //监听屏幕方向
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func demoClusreTest(dd: Int,block:@escaping (Int)->(Int)) {
        print("it's ok")
    }
    
    
    @objc func progressChanged(timer: Timer)  {
        print("执行进度方法")
        proFloatValue += 0.01
        if Double(proFloatValue) >= 1 {
            timer.invalidate()
        }
        progressView.setProgress(Float(proFloatValue), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ffPlayer.prepareToPlay()
    
        ///强行设置旋转方向
//        let orientationUnknown = NSNumber.init(value: UIInterfaceOrientation.unknown.rawValue)
//        UIDevice.current.setValue(orientationUnknown, forKey: "orientation")
//        let orientationTarget = NSNumber.init(value: UIInterfaceOrientation.landscapeLeft.rawValue)
//        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.ffPlayer.shutdown()
    }
    //工具栏隐藏/显示
    lazy var tapGeasture: UITapGestureRecognizer = {
        let tap  = UITapGestureRecognizer.init(target: self, action: #selector(toolbarHideOrRise(tapGeasture:)))
        return tap
    }()
    

    //播放器
    lazy var ffPlayer: IJKFFMoviePlayerController = {
        let options: IJKFFOptions = IJKFFOptions.byDefault()
        options.setFormatOptionIntValue(0, forKey: "auto_convert")
        //"https://hls01open.ys7.com/openlive/37069e90237644578a996077ff1d5f51.m3u8"
        let url = URL.init(string:playUrl ?? "")
        let player = IJKFFMoviePlayerController.init(contentURL: url, with: options)
        player?.view.backgroundColor = .white
        player?.scalingMode = .fill
        player?.shouldAutoplay = true
        player?.view.addGestureRecognizer(self.tapGeasture)
        return player!
    }()
    
    lazy var topPalyBar: UIView = {
        let topView = UIView.init()
        topView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return topView
    }()
    
    lazy var bottomPlayBar: UIView = {
        let bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return bottomView
    }()
    
    
    lazy var leftPlayBar: UIView = {
        let leftView = UIView.init()
        leftView.backgroundColor = UIColor.black.withAlphaComponent(0)
        return leftView
    }()
    
    lazy var rightPlayBar: UIView = {
        let rightView = UIView.init()
        rightView.backgroundColor = UIColor.black.withAlphaComponent(0)
        return rightView
    }()
    
    lazy var playButton: UIButton = {
        let playBtn = UIButton.init(frame: CGRect.zero)
        playBtn.setBackgroundImage(UIImage.init(named: "播放"), for: UIControl.State.normal)
        playBtn.setBackgroundImage(UIImage.init(named: "暂停"), for: UIControl.State.selected)
        playBtn.addTarget(self, action: #selector(vedioPlay), for: UIControl.Event.touchUpInside)
        return playBtn
    }()
    
    lazy var backButton: UIButton = {
        let backBtn = UIButton.init(frame: CGRect.zero)
        backBtn.setBackgroundColor(UIColor.white.withAlphaComponent(0), forState: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        backBtn.setImage(UIImage.init(named: "返回"), for: .normal)
        backBtn.jt_setEnlargeEdge(80)
        return backBtn
    }()
    
    lazy var openPlayVC: UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.addTarget(self, action: #selector(changeScreenDir), for: UIControl.Event.touchUpInside)
        btn.setBackgroundImage(UIImage.init(named: "全屏"), for: UIControl.State.normal)
        btn.jt_setEnlargeEdge(60)
        return btn
    }()
    
    lazy var playerTitle: UILabel = {
        let label = UILabel.init()
        label.text = "这是一个视频标题"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    
    lazy var pictureButton: UIButton = {
        let picButton = UIButton.init(frame: CGRect.zero)
        picButton.addTarget(self, action: #selector(screenshotFunction), for: UIControl.Event.touchUpInside)
        picButton.setBackgroundImage(UIImage.init(named: "截图"), for: UIControl.State.normal)
        return picButton
    }()
    
    lazy var sharedButton: UIButton = {
        let picButton = UIButton.init(frame: CGRect.zero)
        picButton.addTarget(self, action: #selector(shareVedio), for: UIControl.Event.touchUpInside)
        picButton.setBackgroundImage(UIImage.init(named: "分享"), for: UIControl.State.normal)
        
        return picButton
    }()
    
    lazy var pinLunList: UITableView = {
        let tbList = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tbList.delegate = self
        tbList.dataSource = self
        return tbList
    }()
    
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView.init(frame: CGRect.zero)
        progress.progress = 0;
        progress.progressTintColor = UIColor.blue.withAlphaComponent(0.3)
        progress.trackTintColor = UIColor.clear
        progress.transform = CGAffineTransform(scaleX: 1.0, y: 0.5)
        return progress
    }()
    
    func addSubViews() {
        setupSubViews()
        snapSubViews()
    }
    
    func setupSubViews() {
        view.addSubview(ffPlayer.view)
        view.addSubview(topPalyBar)
        view.addSubview(bottomPlayBar)
        view.addSubview(leftPlayBar)
        view.addSubview(rightPlayBar)

    }
        
    func snapSubViews() {
        
        ffPlayer.view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(230)
        }
        
        topPalyBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(49)
        }
        
        bottomPlayBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(topPalyBar.snp.height)
            make.bottom.equalTo(ffPlayer.view)
        }

        leftPlayBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(49)
            make.top.equalTo(topPalyBar.snp.bottom)
            make.bottom.equalTo(bottomPlayBar.snp.top)
        }

        rightPlayBar.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(49)
            make.top.equalTo(topPalyBar.snp.bottom)
            make.bottom.equalTo(bottomPlayBar.snp.top)
        }
        
        
        //topPalyBar.setPlayerBarGradient(startP: CGPoint(x: 0, y: 1), endP: CGPoint(x: 0, y: 0))
        //bottomPlayBar.setPlayerBarGradient(startP: CGPoint(x: 0, y: 0), endP: CGPoint(x: 0, y: 1))
        //rightPlayBar.setPlayerBarGradient(startP: CGPoint(x: 0, y: 0), endP: CGPoint(x: 1, y: 0))
        //leftPlayBar.setPlayerBarGradient(startP: CGPoint(x: 1, y: 0), endP: CGPoint(x: 0, y: 0))
        topPalyBar.addSubview(playerTitle)
        topPalyBar.addSubview(backButton)
        bottomPlayBar.addSubview(playButton)
        bottomPlayBar.addSubview(openPlayVC)
        bottomPlayBar.addSubview(progressView)
        leftPlayBar.addSubview(pictureButton)
        rightPlayBar.addSubview(sharedButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(topPalyBar)
            make.left.equalTo(15)
            make.height.width.equalTo(20)
        }
        
        playerTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(5)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomPlayBar)
            make.left.equalTo(15)
            make.height.width.equalTo(30)
        }
        
        openPlayVC.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
            make.height.width.equalTo(20)
        }
        
        pictureButton.snp.makeConstraints { (make) in
            make.center.equalTo(leftPlayBar)
            make.height.width.equalTo(20)
        }
        
        sharedButton.snp.makeConstraints { (make) in
            make.center.equalTo(rightPlayBar)
            make.height.width.equalTo(20)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomPlayBar)
            make.left.equalTo(self.playButton.snp.right).offset(15)
            make.right.equalTo(self.openPlayVC.snp.left).offset(-15)
        }
        
    }
    
}

//MARK: actions
extension IJKPlayController {
    @objc func backButtonAction() {
        popVC()
    }
    //切换 横竖屏
    @objc func changeScreenDir() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(hideToolBar), with: self, afterDelay: 5)
        print("旋转视频")
        let device = UIDevice.current
        if device.orientation == .landscapeLeft ||  device.orientation == .landscapeRight {
            print("还原")
            let orientationUnknown = NSNumber.init(value: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationUnknown, forKey: "orientation")
        }else {
            print("靠左")
            let orientationTarget = NSNumber.init(value: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
    //截图
    @objc func screenshotFunction() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(hideToolBar), with: self, afterDelay: 5)
        let image = self.ffPlayer.view.getViewShot()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
        
        print("截图")
    }
    
    //分享
    @objc func shareVedio() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(hideToolBar), with: self, afterDelay: 5)
        let activityVC = UIActivityViewController.init(activityItems: [URL.init(string: "www.baidu.com")], applicationActivities: nil)
        self.present(activityVC, animated: true) {
            
        }
        print("分享")
    }
    
    //播放
    @objc func vedioPlay() {
        self.ffPlayer.play()
    }
}

//MARK - 横竖屏切换
extension IJKPlayController {
    @objc func receivedRotation() {
        let device = UIDevice.current
        switch device.orientation {
        case .landscapeLeft,. landscapeRight:
            ffPlayer.view.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            view.layoutIfNeeded()
        case .portrait:
            ffPlayer.view.transform.rotated(by: CGFloat(-Float.pi))
            ffPlayer.view.snp.remakeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(230)
            }
            view.layoutIfNeeded()
        default:
            ffPlayer.view.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(230)
            }
            view.layoutIfNeeded()
        }
    }
    
    //MARK: 屏幕旋转
    override var shouldAutorotate: Bool {
        return true
        
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeLeft,UIInterfaceOrientationMask.portrait]
    }

    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}
//MARK: 控制栏自动隐藏
extension IJKPlayController {
    @objc func toolbarHideOrRise(tapGeasture: UITapGestureRecognizer) {
        if self.isToolBarHidden {
            self.riseToolBar()
            self.perform(#selector(hideToolBar), with: self, afterDelay: 3)
        }else {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(hideToolBar), with: self, afterDelay: 5)
        }
    }
    
    //第一次进入播放
    func toolbarHide() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.hideToolBar()
        }
    }
    
    @objc func hideToolBar() {
        print("执行一次")
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            self.topPalyBar.snp.remakeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(0)
            }
            
            self.bottomPlayBar.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(0)
                make.bottom.equalTo(self.ffPlayer.view)
            }
            
            self.leftPlayBar.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.width.equalTo(0)
                make.top.equalTo(self.topPalyBar.snp.bottom)
                make.bottom.equalTo(self.bottomPlayBar.snp.top)
            }

            self.rightPlayBar.snp.remakeConstraints { (make) in
                make.right.equalToSuperview()
                make.width.equalTo(0)
                make.top.equalTo(self.topPalyBar.snp.bottom)
                make.bottom.equalTo(self.bottomPlayBar.snp.top)
            }
            self.view.layoutIfNeeded()
        } completion: { (completed) in
            self.topPalyBar.isHidden = true
            self.bottomPlayBar.isHidden = true
            self.leftPlayBar.isHidden = true
            self.rightPlayBar.isHidden = true
            self.isToolBarHidden = true
        }

    }
    
    func riseToolBar() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            self.topPalyBar.isHidden = false
            self.bottomPlayBar.isHidden = false
            self.leftPlayBar.isHidden = false
            self.rightPlayBar.isHidden = false
            
            self.topPalyBar.snp.remakeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(49)
            }
            
            self.bottomPlayBar.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(self.topPalyBar.snp.height)
                make.bottom.equalTo(self.ffPlayer.view)
            }

            self.leftPlayBar.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.width.equalTo(49)
                make.top.equalTo(self.topPalyBar.snp.bottom)
                make.bottom.equalTo(self.bottomPlayBar.snp.top)
            }

            self.rightPlayBar.snp.remakeConstraints { (make) in
                make.right.equalToSuperview()
                make.width.equalTo(49)
                make.top.equalTo(self.topPalyBar.snp.bottom)
                make.bottom.equalTo(self.bottomPlayBar.snp.top)
            }
            self.view.layoutIfNeeded()
        } completion: { (completed) in
            self.isToolBarHidden = false
        }
    }
}

//MARK: delegate & datasource
extension IJKPlayController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil  {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        return cell!
    }
}
