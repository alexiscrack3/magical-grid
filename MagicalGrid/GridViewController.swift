
import UIKit

class GridViewController: UIViewController {
    private let numberViewPerRow = 15
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initData()
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Controller Methods
    private func initData() {
    }
    
    private func setupView() {
        let width = view.bounds.width / CGFloat(numberViewPerRow)
        
        for i in 0...30 {
            for j in 0...numberViewPerRow {
                let rect = CGRect(x: CGFloat(j) * width, y: CGFloat(i) * width, width: width, height: width)
                let subview = UIView(frame: rect)
                subview.backgroundColor = randomColor()
                subview.layer.borderWidth = 0.5
                subview.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(subview)
            }
        }
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
