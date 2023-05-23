import UIKit

class CameraViewController: UIViewController {
    // MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "BeerApp"
        label.textColor = UIColor.textColor
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beerColor
        addEllipseView()
        addLabel()
        log.verbose("ViewController has loaded its view.")
    }
    
    // MARK: - Private Methods
    private func addEllipseView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,
                              y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: 0))
        path.addLine(to: CGPoint(x: view.bounds.width,
                                 y: view.bounds.height * LocalConstants.ellipseHeightMultiplier))
        path.addQuadCurve(to: CGPoint(x: 0,
                                      y: view.bounds.height * LocalConstants.ellipseHeightMultiplier),
                          controlPoint: CGPoint(x: view.bounds.width / 2,
                                                y: view.bounds.height * 0.185))
        path.addLine(to: CGPoint(x: 0,
                                 y: 0))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(shapeLayer)
    }
    
    private func addLabel() {
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 88)
        ])
    }
    
    // MARK: - Constants
    private enum LocalConstants {
        static let ellipseHeightMultiplier: CGFloat = 0.145
        static let cornerRadius: CGFloat = 10
    }
}
