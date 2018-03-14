
import UIKit

class GridViewController: UIViewController {
    private let numberViewPerRow = 15
    private var cells = [String: UIView]()
    private var selectedCell: UIView?
    
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
        
        for x in 0...numberViewPerRow {
            for y in 0...30 {
                let rect = CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width, height: width)
                let cellView = UIView(frame: rect)
                cellView.backgroundColor = randomColor()
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(cellView)
                
                let key = self.cellKey(x, y)
                cells[key] = cellView
            }
        }
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func cellKey(_ x: Int, _ y: Int) -> String {
        let key = "\(x)|\(y)"
        return key
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        let width = self.view.bounds.width / CGFloat(numberViewPerRow)
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        print(x, y)
        
        let key = self.cellKey(x, y)
        guard let cellView = cells[key] else { return }
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        selectedCell = cellView
        
        self.view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
}
