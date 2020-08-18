//
//  Extensions.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/18/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

extension UIView {
    
    public var with :CGFloat{
        return frame.size.width
    }
    public var height :CGFloat{
        return frame.size.height
    }
    public var top :CGFloat{
        return frame.origin.y
    }
    public var bottom :CGFloat{
        return frame.origin.y + frame.size.height
    }
    public var left:CGFloat{
        return frame.origin.x
    }
    public var right :CGFloat{
        return frame.origin.x + frame.size.width
    }
}
extension String{
    func safDatabaseKey()->String{
      return  self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
