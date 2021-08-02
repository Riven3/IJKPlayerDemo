//
//  ViewController.swift
//  Demo
//
//  Created by 金劲通 on 2021/2/1.
//

import UIKit
import IJKMediaFramework



class ViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate {
    var playUrls: [[String : String]] = [["name":"CCTV-1综合",
    "url":"http://223.110.242.130:6610/gitv/live1/G_CCTV-1-HQ/1.m3u8"],
    ["name":"CCTV-2财经",
    "url":"http://112.50.243.10/PLTV/88888888/224/3221225800/1.m3u8"],
    ["name":"CCTV-3综艺",
    "url":"http://183.207.249.14/PLTV/3/224/3221225588/index.m3u8"],
    ["name":"CCTV-4中文国际",
    "url":"http://223.110.242.130:6610/gitv/live1/G_CCTV-4-HQ/1.m3u8"],
    ["name":"CCTV-5体育",
    "url":"http://223.110.243.172/PLTV/3/224/3221227166/index.m3u8"],
    ["name":"CCTV-5+体育赛事",
    "url":"http://223.110.243.162/PLTV/3/224/3221225604/index.m3u8"],
    ["name":"CCTV-6电影",
    "url":"http://223.110.243.139/PLTV/3/224/3221225548/index.m3u8"],
    ["name":"CCTV-7军事农业",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225805/1.m3u8"],
    ["name":"CCTV-8电视剧",
    "url":"http://2.110.243.171/PLTV/3/224/3221227204/index.m3u8"],
    ["name":"CCTV-9记录",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225820/1.m3u8"],
    ["name":"CCTV-10科教",
    "url":"http://183.207.249.14/PLTV/3/224/3221225550/index.m3u8"],
    ["name":"CCTV-11戏曲",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225815/1.m3u8"],
    ["name":"CCTV-12社会与法",
    "url":"http://223.110.245.172/PLTV/3/224/3221225556/index.m3u8"],
    ["name":"CCTV-13新闻",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225817/1.m3u8"],
    ["name":"CCTV-14少儿",
    "url":"http://223.110.245.169/PLTV/3/224/3221227201/index.m3u8"],
    ["name":"CCTV-15音乐",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225818/1.m3u8"],
    ["name":"湖南卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225827/1.m3u8"],
    ["name":"江苏卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225847/1.m3u8"],
    ["name":"浙江卫视高清",
    "url":"http://223.110.243.153/PLTV/3/224/3221227215/index.m3u8"],
    ["name":"东方卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225828/1.m3u8"],
    ["name":"北京卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225826/1.m3u8"],
    ["name":"广东卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225824/1.m3u8"],
    ["name":"深圳卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225848/1.m3u8"],
    ["name":"天津卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225830/1.m3u8"],
    ["name":"安徽卫视高清",
    "url":"http://223.110.243.140/PLTV/3/224/3221225634/index.m3u8"],
    ["name":"山东卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225843/1.m3u8"],
    ["name":"湖北卫视高清",
    "url":"http://223.110。243.140/PLTV/3/224/3221227211/index.m3u8"],
    ["name":"辽宁卫视高清",
    "url":"http://223.110.243.157/PLTV/3/224/3221225566/index.m3u8"],
    ["name":"重庆卫视高清",
    "url":"http://223.110.243.138/PLTV/3/224/3221227421/index.m3u8"],
    ["name":"江西卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225868/1.m3u8"],
    ["name":"河北卫视高清",
    "url":"http://weblive.hebtv.com/live/hbws_bq/index.m3u8"],
    ["name":"黑龙江卫视高清",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225862/1.m3u8"],
    ["name":"四川卫视",
    "url":"http://ott.js.chinamobile.com/PLTV/3/224/3221225814/index.m3u8"],
    ["name":"广西卫视",
    "url":"http://223.110.243.162/PLTV/3/224/3221225554/index.m3u8"],
    ["name":"河南卫视",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225842/1.m3u8"],
    ["name":"山西卫视",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225839/1.m3u8"],
    ["name":"东南卫视",
    "url":"http://223.110.243.158/PLTV/3/224/3221225598/index.m3u8"],
    ["name":"厦门卫视",
    "url":"http://ott.js.chinamobile.com/PLTV/3/224/3221226093/index.m3u8"],
    ["name":"云南卫视",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225853/1.m3u8"],
    ["name":"宁夏卫视",
    "url":"http://223.110.243.166/PLTV/3/224/3221225628/1.m3u8"],
    ["name":"新疆卫视",
    "url":"http://223.110.243.140/PLTV/3/224/3221225523/index.m3u8"],
    ["name":"旅游卫视",
    "url":"http://112.50.243.8/PLTV/88888888/224/3221225855/1.m3u8"],
    ["name":"内蒙古卫视",
    "url":"http://223.110.243.142/PLTV/3/224/3221225624/index.m3u8"],
    ["name":"凤凰中文台超清",
    "url":"http://223.110.243.146/PLTV/3/224/3221226922/index.m3u8"],
    ["name":"凤凰资讯台超清",
    "url":"http://223.110.243.146/PLTV/3/224/3221226923/index.m3u8"],
    ["name":"凤凰香港台超清",
    "url":"http://223.110.243.146/PLTV/3/224/3221226975/index.m3u8"],
    ["name":"Newtv动作电影",
    "url":"http://183.207.249.15/PLTV/3/224/3221225529/index.m3u8"],
    ["name":"Newtv惊悚悬疑",
    "url":"http://183.207.249.7/PLTV/3/224/3221225561/index.m3u8"],
    ["name":"Newtv精品电影",
    "url":"http://183.207.249.14/PLTV/3/224/3221225567/index.m3u8"],
    ["name":"Newtv明星大片",
    "url":"http://183.207.249.14/PLTV/3/224/3221225535/index.m3u8"],
    ["name":"Newtv家庭剧场",
    "url":"http://183.207.249.14/PLTV/3/224/3221225549/index.m3u8"],
    ["name":"Newtv精品大剧",
    "url":"http://183.207.249.14/PLTV/3/224/3221225569/index.m3u8"],
    ["name":"Newtv金牌综艺",
    "url":"http://183.207.249.16/PLTV/3/224/3221225559/index.m3u8"],
   ["name":"Newtv精品记录",
    "url":"http://183.207.249.14/PLTV/3/224/3221225557/index.m3u8"],
    ["name":"Newtv精品体育",
    "url":"http://183.207.249.16/PLTV/3/224/3221225543/index.m3u8"],
    ["name":"Newtv北京纪实",
    "url":"http://117.169.79.101:8080/PLTV/88888888/224/3221225764/index.m3u8"],
    ["name":"Newtv上海纪实",
    "url":"http://huaweicdn.hb.chinamobile.com/PLTV/88888888/224/3221225769/3.m3u8"],
    ["name": "Newtv纪实天下(电)",
    "url":"rtsp://120.205.96.36:554/live/ch16022917175374294745.sdp?playtype=1&boid=001&backupagent=120.205.32.36:554&clienttype=1&time=20161205230814+08&life=172800&ifpricereqsnd=1&vcdnid=001&userid=&mediaid=ch16022917175374294745&ctype=2&TSTVTimeLife=60&contname=&authid=0&terminalflag=1&UserLiveType=0&stbid=&nodelevel=3"],
    ["name":"Newtv全纪实",
    "url":"http://huaweicdn.hb.chinamobile.com/PLTV/88888888/224/3221225791/3.m3u8"],
    ["name":"Newtv欢笑剧场",
    "url":"http://huaweicdn.hb.chinamobile.com/PLTV/88888888/224/3221225776/3.m3u8"],
    ["name":"Newtv都市剧场",
    "url":"http://huaweicdn.hb.chinamobile.com/PLTV/88888888/224/3221225754/3.m3u8"]]
    
    override var hideNavigationBar: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(ijkListView)
        ijkListView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    lazy var ijkFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.itemSize = CGSize(width: (screen_width - 48) / 2, height: (screen_width - 48) / 4)
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16 )
        return flowLayout
    }()
    
    lazy var ijkListView: UICollectionView = {
        let listView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: ijkFlowLayout)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = .white
        listView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return listView
    }()
        
    func createIJKListView() {
        
    }
    
    
}
//MARK: 屏幕旋转
extension ViewController {
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.contentView.removeSubviews()
        let label = UILabel.init()
        label.textColor = .white
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(cell.contentView)
        }
        label.textAlignment = NSTextAlignment.center
        label.text = self.playUrls[indexPath.row]["name"]
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = IJKPlayController.init()
        vc.playUrl = self.playUrls[indexPath.row]["url"]
        vc.playerTitle.text = self.playUrls[indexPath.row]["name"]
        navigationController?.pushViewController(vc, animated: true)
//        let vc = BlueToothController.init()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
