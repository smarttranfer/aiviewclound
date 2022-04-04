//
//  QRViewFactory.swift
//  flutter_qr
//
//  Created by Dũng Đình Nguyễn on 10/08/21.
//

import Foundation

public class QRViewFactory: NSObject, FlutterPlatformViewFactory {
    
    var registrar: FlutterPluginRegistrar?
    
    public init(withRegistrar registrar: FlutterPluginRegistrar){
        super.init()
        self.registrar = registrar
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as! Dictionary<String, Double>
        return QRView(withFrame: frame, withRegistrar: registrar!,withId: viewId, params: params)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec(readerWriter: FlutterStandardReaderWriter())
    }
}
