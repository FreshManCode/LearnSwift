//
//  SWAVFoundationListVCExtension.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation
import AVFoundation
import AssetsLibrary
import MediaPlayer


extension SWAVFoundationListVC {
    
    
    
    
    // MARK: - AVSpeechUtterance简单语音播放播放
    @objc func simpleAVSpeechUtterance () {
        let synthesizer = AVSpeechSynthesizer()
        let utterAnce = AVSpeechUtterance.init(string: "Hello wordl!")
        synthesizer.speak(utterAnce)
//      该代码进行简单的语音播报
    }
    
    // MARK: - 中文语音播报
    @objc func simpleChineseRadio () {
//      如果给中文,则以中文方式播报,如果给英文则播放英文
        let utterance = AVSpeechUtterance.init(string: "大家好跑")
//      设置播放的语种
        utterance.voice = self.voices[0]
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.8
//      如果是多段播放,在播放完毕时停顿的短暂时间
        utterance.postUtteranceDelay = 0.1
        self.mySynthesizer.speak(utterance)
//      该代码进行简单的语音播报
    }
    
    // MARK: - 英文播通知
    @objc func simpleEnglishRadio () {
        /// 只读取英文部分,中文部分不显示
        let utterance = AVSpeechUtterance.init(string: "中国好Good")
        utterance.voice = self.voices[1]
        utterance.rate = 0.40
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.1
        self.mySynthesizer.speak(utterance)
//      该代码进行简单的语音播报
    }
    
    // MARK: - section2
    @objc func aboutAudioSession() {
        let  string = "音频会话在应用程序和操作系统之间扮演着中间人的角色.它提供了一种简单实际的方法使OS得知应用程序应该如何与iOS音频进行交互.\n\n" +
            "所有iOS应用程序都具有音频会话,无论其是否使用.默认音频会话来自以下一些预配置" +
        "\n *激活了音频播放,但是音频录制未激活" +
        "\n *当用户切换响铃/静音开关到\"静音\"模式时,应用程序播放所有的音频都会消失" +
        "\n *当设置显示解锁屏幕时,应用程序的音频处于静音状态" +
        "\n *当应用程序播放音频时,所有后台播放的音频都会处于静音状态"
        setText(string)
    }

    
    // MARK: - 使用AVAudioPlayer播放音频
    @objc func playerVoiceWithAvAudioPlayer () {
        //1.创建AVAudioPlayer ,一共两种方法,一种是播放音频的内存版本的NSData,或者本地音频文件NSURL.
        //如果是iOS系统,URL必须是在应用程序沙盒之内
        let fileURL = Bundle.main.url(forResource: "泡沫", withExtension: "mp3")
        guard let myFileURL = fileURL else { return  }
        do {
             player = try AVAudioPlayer.init(contentsOf: myFileURL)
        } catch  {
            printLog("Error is:",error)
        }
//prepareToPlay 方法会取得苏需要的音频硬件并预加载Audio Queue的缓存区.
        player?.prepareToPlay()
        player?.play()
        
        /**
         1.play 方法可以实现立即播放音频的功能,pause方法可以对播放暂停,那么可想而知stop方法可以停止播放行为.
         2.调用pause和stop方法停止播放的音频都会继续播放,这两者最主要的区别在底层处理上.调用stop方法会撤销prepareToPlay时所做的设置,
         而调用pause方法则不会
         
         除了常规方法之外,还可以使用其他一些有趣的方法,如下所示:
         *修改播放器的音量:比如渐隐效果
         *修改播放器的pan值:允许使用立体声播放声音.
         *调整播放率:(范围从0.5倍速到2.0倍速)
         *通过设置numberOfLoops属性实现音频无缝循环.
         
         音频播放可以是未压缩的PCM音频,也可以是AAC之类的压缩格式视频
         
         *进行音频计量:当播放发生时从播放器读取音量力度的平均值及峰值.可将这些数据提供给VU计量器或其他可视化原件,
         向用户提供可视化的反馈效果
         */
    }
    
    // MARK: - 创建Audio Looper
    @objc func createAudioLooper()  {
        self.navigationController?.pushViewController(SWAudioLooperViewController(), animated: true)
    }
    
    // MARK: - 4.配置音频会话
    @objc func configAudioSession () {
        /* 所有iOS应用程序都自动带有一个默认音频会话,分类名称为Solo Ambient.这个类型可以播放音频,但对于一个主要功能为播放的应用
         程序来说并不合适.由于默认分类不能提供我们期望的功能,需要对音频会话进行更明确的配置.音频会话通常会在应用程序启动时进行一次配置,
         所以可将配置代码写在AppDelegate中.
         */
    }
    
    // MARK: - 5.处理中断事件
    @objc  func handleInterruptionEvent()  {
        /*
         中断在iOS设备中经常出现,在使用设备的过程中经常会有电话呼入,闹钟响起及弹出FaceTime等情况.虽然iOS系统本身可以很好地处理这些事件,
         不过我们还是要确保自己针对这些情况处理的够完美.
         
         音频会话通知:
         在准备出现的中断事件采取动作前,首先需要得到中断出现的通知,注册应用程序的AVAudioSession发送的通知
         AVAudioSessionInterruptionNotification.在控制器的init方法中注册该通知.
         
         推送的通知会包含一个带有多许多重要信息的userInfo字典,根据这个字典可以确定采取哪些合适的操作.
         在处理的方法中 根据 AVAudioSessionInterruptionTypeKey 的值确定中断的类型.返回值是AVAudioSessionInterruptionType
         ,这是用于表示中断开始或者结束的枚举类型.
         */
    }
    
    // MARK: - 6.对线路改变的响应
    @objc func respondToChangeLine() {
        /* 在iOS设备上添加或者移除音频输入,输出线路时,会发生线路改变.有多重原因会导致线路的变化,比如用户插入耳机或断开USB麦克风.当
         这些事件发生时,音频会根据情况改变输入或输出线路,同时AVAudioSession会广播一个描述该变化的通知给所有相关的侦听器.
         
         下面对音频播放做个测试,在播放期间插入耳机.音频输出线路变为耳机插孔并继续正常播放,这就是所要的效果.保持音频处于播放状态,断开耳机
         连接.音频线路再次回到设备的内置扬声器,我们再次听到了声音.
         当线路变化时,有相关的通知.我们首先注册AVAudioSession发送的通知,该通知名为AVAudioSessionRouteChangeNotification.该
         通知包含一个userinfo字典,该字典带有相应通知发送的原因信息及前一个线路的描述,这样我们就可以确定线路变化的情况了.
         
         收到通知后第一件事情就是判断线路发生变更的原因.查看保存在userinfo字典中表示原因的AVAudioSessionRouteChangeReasonKey的值
         这个返回值是一个用于表示变化原因的无符号整数.通过原因推断出不同的事件.
         
         知道有设备断开连接后,从userinfo字典中获取用于描述前一个线路的AVAudioSessionRouteDescription.线路的描述信息整合在一个
         输入NSArray 和一个输入NSArray中.数组中的元素都是AVAudioSessionPortDescription的实例,用于描述不同的I/O接口属性.
         在本例中,需要从线路描述中找到第一个输出接口并判断是否为耳机接口.如果是,则停止播放.并传递相应的状态.
         
         THPlayerController 类中对拔出耳机做出了相应的处理.具体可以查看相应class
         */
    }
    
    // MARK: - 7.使用AVAudioRecorder录制音频
    @objc func useAVAudioRecorder() {
        self.navigationController?.pushViewController(SWAudioRecorderViewController(), animated: true)
    }
    
    // MARK: - 3 资源和元数据
    @objc func resourceAndAsset() {
        /* 1.理解资源的含义
         AVFoundation最重要的类就是AVAsset,它是AVFoundation设计的核心,在几乎所有特性和功能的开发中扮演着至关重要的角色.AVAsset
         是一个抽象类和不可变类,定义了媒体资源混合呈现的方式,将媒体资源的静态属性模块化成一个整体,比如标题,时长和元数据等.明确理解
         AVAsset的目标和功能对成功应用AVFoundation非常重要.
         
         AVAsset不需要考虑媒体资源所具有的两个重要范畴.第一是它提供了对基本媒体格式层的抽象,这意味着无论是处理QuickTime影片,MPEG-4视频还是
         MP3音频,对我们和框架而言,面对的只有资源这个概念.这就使得开发者在面对不同格式的内容时有一个统一的处理方法,不需要考虑多种编码器和
         容器格式因为细节不同而带来的困扰.此外,AVAsset隐藏了资源的位置信息,当我们对一个现有媒体对象进行处理时,会通过URL进行初始化来创建一个资源.
         这个地址可能是指向本地应用程序的URL,可能是文件系统的其它位置,也可能是从用户ipod库中得到的URL,甚至可能是从远程服务器上的一个音频流或视频流的URL.
         
         因为不用考虑媒体格式及位置等复杂问题,AVAsset为开发者处理时基媒体(timed media)提供了一种简单,统一的方式.
         
         AVAsset本身并不是媒体资源,但是它可以作为时基媒体的容器.它由一个或多个带有描述自身元数据的媒体组成.我们使用AVAssetTrack类代表保存在资源中的统一
         类型媒体,并对每个资源建立相应的模型.AVAssetTrack最常见的形态就是音频和视频流,但是它还可以用于表示诸如文本,副标题或隐藏字幕等媒体类型
         */
        
        /*
         3.2 创建资源
         当我们为一个现有的媒体资源创建AVAsset对象时,可以通过URL对它进行初始化来实现.一般来说是一个本地文件URL,但是也可以是远程URL.
         
         let assetURL = URL.init(fileURLWithPath: "")
         let asset = AVAsset(url: assetURL)
         
         AVAsset是一个抽象类,意味着它不能直接被实例化.当使用它的assetWithURL:方法创建实例时,实际上是创建了它子类的一个实例,子类名为AVURLAsset.有时我们
         会直接使用这个类,因为它允许通过传递选项字典来精细调整资源的创建方式.比如,如果创建一个用在音频或视频编辑场景中的资源,可能希望传递一个选项(option)
         来告诉程序提供更精确的时长和计时信息如下所示:
         */
        let assetURL = URL.init(fileURLWithPath: "")
        let options = [AVURLAssetPreferPreciseDurationAndTimingKey:NSNumber(true)]
        let asset = AVURLAsset.init(url: assetURL, options: options)
        
        /* 3.2.1 iOS Asset库
         用户使用系统自带的Camera程序或第三方视频捕捉程序捕捉的视频,它们通常保存在用户的照片库中.iOS提供的Assets库框架可以实现从照片库中读写的功能.
         下例:从用户资源库中的视频创建一个AVAsset
         
         下例展示了如何获取保存在Saved Photos组中的视频资源,程序在这个组中筛选出视频内容,并获取结果集合中的第一个视频资源.库中的条目全部被建模为ALAsset对象
         为默认呈现方式选用ALAsset类型会返回一个ALAssetRepresentation,它提供了一个适于创建AVAsset的URL
         
         */
        
        let library = ALAssetsLibrary.init()
        library.enumerateGroups(withTypes: ALAssetsGroupType(ALAssetsGroupSavedPhotos)) { (group, stop) in
            group?.setAssetsFilter(ALAssetsFilter.allVideos())
            group?.enumerateAssets(at: NSIndexSet.init(index: 0) as IndexSet,
                                   options: NSEnumerationOptions(rawValue: 0),
                                   using: { (alAsset, index, innerStop) in
                                    if alAsset != nil {
                                        let representation = alAsset?.defaultRepresentation()
                                        let url = representation?.url()
                                        let asset = AVAsset.init(url: url!)
                                        printLog("asset is:\(asset) url is:\(url) representation is:\(representation) ")
                                    }
            })
        } failureBlock: { (error) in
            printLog("error is:\(error?.localizedDescription)")
        }
        
    }
    
    // MARK: - 3.2.2 iOS iPod库
    @objc func iOSiPodResource()  {
        /* 获取媒体的一个常见位置是用户的iPod库,MediaPlayer框架提供了API.实现在这个库中查询和获取条目.当需要的条目找到后,可以获取其URL并使用这个URL
         初始化一个资源,如下:
         */
        let artistPredivate = MPMediaPropertyPredicate.init(value: "Foo Fighters", forProperty: MPMediaItemPropertyArtist)
        let albumPrdicate = MPMediaPropertyPredicate.init(value: "In Your Honor", forProperty: MPMediaItemPropertyAlbumTitle)
        let songPredicate = MPMediaPropertyPredicate.init(value: "Bese of You", forProperty: MPMediaItemPropertyTitle)
        
        let query = MPMediaQuery()
        query.addFilterPredicate(artistPredivate)
        query.addFilterPredicate(albumPrdicate)
        query.addFilterPredicate(songPredicate)
        let result = query.items
        guard let _ = result else {
            return
        }
        if result!.count > 0 {
            let item = result![0]
            let assetURL = item.value(forProperty: MPMediaItemPropertyAssetURL)
            let asset = AVAsset.init(url: assetURL as! URL)
        } else {
            printLog("no search result")
        }
        /*
         MPMediaPlayer框架提供了一个名为MPMediaPropertyPredicate 的类,它用于构建帮助用户在iPod库中查找具体内容所用的查询语句.上述事例嗲吗在Foo Fighters
         的 In Your Honor 唱片中查找 Bese of You 这首歌.在一条语句查询成功执行后,会捕捉到这个媒体条目的资源URL属性,并使用这个属性创建一个AVAsset
         */
    }
    
    // MARK: - 3.3 异步载入
    @objc func asyncLoad() {
        /* AVAsset 和AVAssetTrack 都采用了AVAsyncchrounousKeyValueLoading协议.
         该协议通过下面给出的这些方法实现了异步查询属性的功能:
         可使用 statusOfValueForKey:error 方法查询一个给定属性的状态,该方法会返回一个枚举类型的AVKeyValuesStatus的值,用于表示当前所请求的属性的状态.
         如果状态不是AVKeyValueStatusLoaded,意味着此时请求该属性可能会导致程序卡顿.要异步载入一个给定的属性,可以调用
         loadValuesAsnychronouslyForKeys:completionHandler:方法,为其提供一个具有一个或多个key的数组(资源的属性名)和一个completionHandler块,
         当资源处于回应请求的状态时,就会调用这个completionHandler块,如下例所示:
         */
        
        let assetURL = Bundle.main.url(forResource: "Hubblecast", withExtension: "mov")
        guard let _ = assetURL else {
            printLog("assetURL is nil")
            return  }
        let asset = AVAsset(url: assetURL!)
        
        //异步加载tracks属性
        let keys = ["tracks"]
        asset.loadValuesAsynchronously(forKeys: keys) {
//error 必须定义为可选类型
            var error:NSError?
            let status = asset.statusOfValue(forKey: "tracks", error: &error)
            switch status {
            case .loaded:
                printLog("已经加载,可以继续处理")
            case .failed :
                printLog("加载失败")
            case .cancelled:
                printLog("处理显示取消操作")
            default:
                printLog("status:\(status)")
            }
            
        }
        /* 注意:该例载入一个tracks属性,其实可以在一个调用中请求多个属性,当请求多个属性时,需要注意以下两点:
         1.每次调用loadValuesAsynchronously(forKeys:completionHandler:)方法时只会调用一次completionHandler块.
         调用该方法的次数并不是根据传递给这个方法的键的个数耳钉的.
         
         2.需要为每个请求的属性调用statusOfValue(forKey: , error: )方法,不能假设所有的属性都返回相同的状态值
         */
    }
    
    // MARK: - 3.4 媒体元数据
    @objc func mediaAsset() {
        /* 元数据格式:
         虽然存在多种格式的媒体资源,但是我们在Apple环境下遇到的媒体类型主要由4种,分别是:QuickTime(mov),MPEG-4 video(mp4和m4v),
         MPEG-4 audio (m4a)和MPEG-Layer audio (mp3).虽然AV Foundation 在处理这些文件中嵌入的元数据时都使用一个接口,但是
         理解这些不同类型资源的元数据如何存储及存储位置仍然很有价值.
         */
        
        /* 3.5.2 使用AVMetadataItem
         
         */
        let path = Bundle.main.path(forResource: "2", ofType: "mp3")
        guard let _ = path else {
            printLog("load path error")
            return  }
        let url = URL.init(fileURLWithPath: path!)
        let asset = AVAsset.init(url: url)
        let metaDataArray = asset.metadata(forFormat: AVMetadataFormat.iTunesMetadata)
        if metaDataArray.isEmpty {
            printLog("metaDataArray is empty")
            return
        }
        
        for item in metaDataArray {
            printLog("\(item.key):\(item.value)")
        }
    }
    
    // MARK: - 4.视频播放
    @objc func playVideoSummary () {
        /*
         4.1.1 AVPlayer
         
         AV Foundation 的播放都是围绕着AVPlayer类展开,AVPlayer是一个用来播放基于时间的视听媒体的控制器对象.支持播放从本地,
         分步下载或通过HTTP Live Streaming协议得到的流媒体,并在多种场景中播放这些视频资源.需要说明的是,当我们说"控制器时",
         是指我们通常的理解,它不是一个视图或者窗口控制器,而是一个对播放和资源时间相关信息进行管理的对象.
         开发者通过框架提供的应用程序接口来开发控制播放基于时间的媒体的用户界面.
         
         AVPlayer是一个不可见组件,如果播放MP3或AAC音频文件,那么没有可视化的用户界面也不会有什么问题.不过如果要播放
         一个Qucktime电影或MPEG-4视频,会导致不好的体验.要将视频资源导出到用户界面的目标位置,需要使用AVPlayerLayer类.
         
         注意:AVPlayer只管理一个单独资源的播放,不过框架还提供了AVPlayer的一个子类AVQueuePlayer,可以用来管理一个资源队列,
         当你需要在一个序列中播放多个条目或者为音频,视频资源设置播放循环时可使用该子类.
         
         4.1.2 AVPlayerLayer
         
         AVPlayerLayer 构建于CoreAnimation之上,是AV Foundation中能找到的为数不多的可见组件.
         CoreAnimation 本身具有基于时间的属性,并且由于它基于OPENGL,所以具有很好的性能,能非常好地满足AVFoundation的需要.
         
         AVPlayerLayer扩展了CoreAnimation的CALayer类,并通过框架在屏幕上显示视频内容.这一图层并不提供任何可视化控件
         或其他附件(根据开发者需求搭建的.),但是它用作视频内容的渲染面.创建AVPlayerLayer需要一个指向AVPlayer实例的指针,
         这就将图层和视频播放器紧密绑定在一起,保证了当播放器基于时间的方法出现时使二者保持同步.AVPlayerLayer与其他CALayer
         一样,可以设置为UIView或NSView的备用层,或者可以手动添加到一个已有的继承关系中.
         
         AVPlayerLayer是一个相对简单的类,使用起来简单.在这一层中开发者可以自定义的领域只有Video gravity.总共为Video gravity
         定义三个不同的gravity值,用来确定在继承层的范围内视频可以拉伸或缩放的程度.
         
         AVLayerVideoGravityResizeAspect:
         会在继承层的范围内缩放视频大小来保持视频的宽高比.这是在没有其他设置情况下的默认值,适用于绝大多数情况.
         
         AVLayerVideoGravityResizeAspectFill:
         保留视频的宽高比,并使其通过缩放填满层的范围区域,通常会导致视频图片被部分裁剪.
         
         
         4.1.3 AVPlayerItem
         
         AVPlayerItem会建立媒体资源动态视角的数据模型并保存AVPlayer在播放资源时的呈现状态.在这个类中我们会看到诸如seekToTime:
         的方法以及访问currentTime和presentationSize的属性.AVPlayerItem由一个或多个媒体曲目组成,由AVPlayerItemTrack
         类建立模型.AVPlayerItemTrack实例用于表示播放器条目中的类型统一的媒体流,比如:音频或视频.
         AVPlayerItem中的曲目直接与基础AVAsset中的AVAssetTrack实例相对应.
         */
    }
    
    // MARK: - 4.2 播放秘籍
    @objc func playSecretary () {
        //1.获取URL
        let assetURL = Bundle.main.url(forResource: "曹操", withExtension: "mp4")
        guard let _ = assetURL else {return}
        
        //2.创建AVAsset 实例
        let avasset = AVAsset.init(url: assetURL!)
        
        //3.创建一个AVPlayerItem
        let avPlayerItem = AVPlayerItem.init(asset: avasset)
        
        avPlayerItem.addObserver(self,
                                 forKeyPath: "status",
                                 options: .new,
                                 context:&MyExtensionKey.PlayerItemStatusContext)
        
        //4.根据AVPlayerItem实例创建AVPlayer实例
        self.avPlayer = AVPlayer.init(playerItem: avPlayerItem)
        
        //5.创建一个指向视频内容的layer图层
        let playerLayer = AVPlayerLayer.init(player: self.avPlayer)
        
        //6.把创建的视频内容图层关联到layer层级上
        self.view.layer.addSublayer(playerLayer)
        
        /* 本例中对播放视频文件所需的基础框架进行了设置.不过在实际播放视频内容前还需要一个额外的步骤,这是因为播放器的播放控件
         还没有为播放动作做好准备.AVPlayerItem没有准备播放的界面,不过取而代之的是基于"主动发起请求的机制"
         
         AVPlayerItem 具有一个名为status的AVPlayerItemStatus类型的属性.在对象创建之初,播放条目由
         AVPlayerItemStatusUnknown状态开始,该状态表示当前媒体还未载入并且还不在播放队列中.将AVPlayerItem
         与一个AVPlayer对象进行关联就开始讲媒体放入队列中,但是在具体内容可以播放前,需要等待对象的状态由
         AVPlayerItemStatusUnknown 变为AVPlayerItemStatusReadyToPlay.开发者通过KVO机制监听status属性的值
         来跟踪这一变化过程.
         
         */
    }
    
    // MARK: - 4.3 处理时间
    @objc func handleTime () {
        /* CMTime
         
         AVFoundation是基于CoreMedia的高层封装.CoreMedia是基于C的底层框架,提供了许多处理MAC和iOS媒体栈的关键功能.
         虽然这个框架通常都是在后台工作,不过其中一个我们经常能够接触到的部分就是它的数据结构CMTime.CMTime为时间的正确表示
         给出了一种结构,即分数值的方式.
         下面了解如何使用CMTimeMake函数创建时间
         */
        
        //0.5 s
        let halfSecond = CMTimeMake(value: 1, timescale: 2)
        
        //5s
        let fiveSeconds = CMTimeMake(value: 5, timescale: 1)
    }
    
    // MARK: - 4.4 创建视频播放器
    @objc func createVideoPlayer () {
        /* 视图本身并不是视频输出的目标,相反,开发者需要将播放器输出指向一个AVPlayerLayer实例.可以手动创建层,并将它添加到
         视图的层级继承关系中,但是在iOS平台下有一种更便捷的方法.UIView视图都受CoreAnimation层的支持,默认情况下,就是CALayer
         的通用实例,不过可以通过在UIView中重写layerClass方法自定义支持层的类型,以便在实例化一个视图的时候返回一个要使用的
         自定义CALayer.在使用AVPlayerLayer对象时上述方法更加方便,因为不需要手动创建和操作层以及层基层关系.
         
         */
        self.navigationController?.pushViewController(SWCreateVideoViewController(), animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if context == &MyExtensionKey.PlayerItemStatusContext {
            let playerItem = object as? AVPlayerItem
            guard let myPlayerItem = playerItem else {return}
            printLog("playerItem status:\(myPlayerItem.status.rawValue)")
            if myPlayerItem.status == AVPlayerItem.Status.readyToPlay {
                printLog("可以准备播放了哦")
            }

        }
    }
    
}
    
