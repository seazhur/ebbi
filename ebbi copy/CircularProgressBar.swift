//
//  CircularProgressBar.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/28/21.
//


import UIKit


class CircularProgressBar: UIView {
    
    
    //MARK: awakeFromNib
    
    
    override func awakeFromNib() {
        // do this until entire loading processes is complete
        super.awakeFromNib()
        setupView()
        label.text = "0"
        label.textColor = UIColor.white
    }

    
    //MARK: Public
    
    
    public var lineWidth:CGFloat = 20 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 40 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    public var safePercent: Int = 100 {
        didSet{
            setForegroundLayerColorForSafePercent()
        }
    }
    
    public func setProgress(to progressConstant: Double, withAnimation: Bool) {
        
        // creates progress as perfected progressConstant
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        // sets the spot where the stroke ends
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        // animates circular completion bar
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = 1
            
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
        }
        
        // changes numbers in animation, sets completion color
        var currentTime:Double = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            if currentTime >= 1{
                timer.invalidate()
            } else {
                currentTime += 0.05
                let percent = currentTime * 100 // currentTime/2 * 100
                self.label.text = "\(Int(progress * percent))%"
                self.setForegroundLayerColorForSafePercent()
                self.configLabel()
            }
        }
        timer.fire()

    }
    
    
    //MARK: Private
    
    
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat { get{ return (self.frame.height - lineWidth)/2.5 } }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    private func drawForegroundLayer(){
        let startAngle = -(5*CGFloat.pi/4) // (-CGFloat.pi/2)
        let endAngle = startAngle + (3*CGFloat.pi/2) // 2 * CGFloat.pi + startAngle
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = UIColor.white.cgColor
        foregroundLayer.strokeEnd = 0
        self.layer.addSublayer(foregroundLayer)
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = UIFont.systemFont(ofSize: labelSize)
        label.sizeToFit()
        label.center = pathCenter
        return label
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    private func setForegroundLayerColorForSafePercent(){
        if Int(label.text!.dropLast())! >= self.safePercent {
            self.foregroundLayer.strokeColor = UIColor.systemGreen.cgColor // UIColor(red: 0.0/255.0, green: 168.0/255.0, blue: 133.0/255.0, alpha: 255.0/255.0).cgColor // UIColor.green.cgColor
        } else {
            self.foregroundLayer.strokeColor = UIColor.white.cgColor // UIColor(red: 84.0/255.0, green: 172.0/255.0, blue: 210.0/255.0, alpha: 255.0/255.0).cgColor // UIColor.red.cgColor
        }        
    }
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
    }
    
    //Layout Sublayers
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }
    
    
}





