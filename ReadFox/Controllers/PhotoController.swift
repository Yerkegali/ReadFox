//
//  PhotoController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 19.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    var delegate: PhotoControllerDelegate?
    
    let topView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        v.alpha = 0.5
        return v
    }()
    
    let cancelButton: UIButton = {
        let b = UIButton()
        b.setTitle("Cancel", for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        b.tintColor = UIColor.white
        b.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return b
    }()
    
    let takePhotoButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 30
        b.backgroundColor = UIColor.white
        b.clipsToBounds = true
        b.alpha = 1
        b.addTarget(self, action: #selector(takePhotoBtnPressed), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.isHidden = true
        setupView()
        setupConstraints()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPrewievLayer()
        setupRunningCaptureSession()
    }
    
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecJPEG])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error.localizedDescription)
        }
    }
    func setupPrewievLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    func setupRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    @objc func takePhotoBtnPressed(){
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func cancelButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoController {
    
    private func setupView(){
        self.view.addSubview(takePhotoButton)
        self.view.addSubview(topView)
        self.topView.addSubview(cancelButton)
    }
    
    private func setupConstraints(){
        
        takePhotoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        takePhotoButton.anchor(top: nil, leading: nil, bottom: self.view.safeBottomAnchor, trailing: nil, padding: .init(top: 0.0, left: 0.0, bottom: 15.0, right: 0.0), size: .init(width: self.view.frame.width/5.079, height: self.view.frame.height/9.015))
        
        topView.anchor(top: self.view.safeTopAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.view.frame.width, height: 60.0))
        cancelButton.anchor(top: self.view.safeTopAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16.0, left: 10.0, bottom: 0.0, right: 0.0), size: .init(width: 55.0, height: 30.0))
    }
}

extension PhotoController: AVCapturePhotoCaptureDelegate {
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            let newVC = NewBookController()
            newVC.bookImage = self.image
            let photoVC2 = PhotoController2()
            photoVC2.image = self.image
            photoVC2.delegate = delegate
            self.navigationController?.pushViewController(photoVC2, animated: false)
        }
    }
}

