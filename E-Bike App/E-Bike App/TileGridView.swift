

import UIKit
//import Commons

class TileGridView: UIView {
  
  fileprivate var containerView: UIView!
  fileprivate var modelTileView: TileView!
  fileprivate var centerTileView: TileView? = nil
  fileprivate var numberOfRows = 0
  fileprivate var numberOfColumns = 0
  
  fileprivate var logoLabel: UILabel!
  fileprivate var tileViewRows: [[TileView]] = []
  fileprivate var beginTime: CFTimeInterval = 0
  fileprivate let kRippleDelayMultiplier: TimeInterval = 0.0006666
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.center = center
    modelTileView.center = containerView.center
    if let centerTileView = centerTileView {
      // Custom offset needed for UILabel font
      let center = CGPoint(x: centerTileView.bounds.midX + 31, y: centerTileView.bounds.midY)
      logoLabel.center = center
    }
  }
  
  init(TileFileName: String) {
    modelTileView = TileView(TileFileName: TileFileName)
    super.init(frame: CGRect.zero)
    clipsToBounds = true
    layer.masksToBounds = true
    
    containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 630.0, height: 990.0))
    containerView.backgroundColor = UIColor.DTIBlue()
    containerView.clipsToBounds = false
    containerView.layer.masksToBounds = false
    addSubview(containerView)
    
    renderTileViews()
    
    logoLabel = generateLogoLabel()
    centerTileView?.addSubview(logoLabel)
    layoutIfNeeded()
  }
  
  func startAnimating() {
    beginTime = CACurrentMediaTime()
    startAnimatingWithBeginTime(beginTime)
  }
}

extension TileGridView {
  
  fileprivate func generateLogoLabel()->UILabel {
    let label = UILabel()
    label.text = "F         BER"
    label.font = UIFont.systemFont(ofSize: 50)
    label.textColor = UIColor.white
    label.sizeToFit()
    label.center = CGPoint(x: bounds.midX, y: bounds.midY)
    return label
  }
  
  fileprivate func renderTileViews() {
    let width = containerView.bounds.width
    let height = containerView.bounds.height
    
    let modelImageWidth = modelTileView.bounds.width
    let modelImageHeight = modelTileView.bounds.height
    
    numberOfColumns = Int(ceil((width - modelTileView.bounds.size.width / 2.0) / modelTileView.bounds.size.width))
    numberOfRows = Int(ceil((height - modelTileView.bounds.size.height / 2.0) / modelTileView.bounds.size.height))
    
    for y in 0..<numberOfRows {
      
      var tileRows: [TileView] = []
      for x in 0..<numberOfColumns {
        
        let view = TileView()
        view.frame = CGRect(x: CGFloat(x) * modelImageWidth, y:CGFloat(y) * modelImageHeight, width: modelImageWidth, height: modelImageHeight)
        
        if view.center == containerView.center {
          centerTileView = view
        }
        
        containerView.addSubview(view)
        tileRows.append(view)
        
        if y != 0 && y != numberOfRows - 1 && x != 0 && x != numberOfColumns - 1 {
          view.shouldEnableRipple = true
        }
      }
      
      tileViewRows.append(tileRows)
    }
    
    if let centerTileView = centerTileView {
      containerView.bringSubview(toFront: centerTileView)
    }
  }
  
  fileprivate func startAnimatingWithBeginTime(_ beginTime: TimeInterval) {
  }
  
}

