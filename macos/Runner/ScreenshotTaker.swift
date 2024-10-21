//
//  ScreenshotTaker.swift
//  Runner
//
//  Created by Arturs Sosnars on 12/10/2024.
//

import Foundation
import Cocoa

class ScreenshotManager {
    static let shared = ScreenshotManager()
    
    public func screen_capturer() {
        let screenshotData = captureScreenshotData()
        guard let data = screenshotData else { return }
        writeTextToFile(jpegData: data)
    }
    
    private func captureScreenshotData() -> Data? {
        let screenFrame = NSScreen.main?.frame ?? .zero
        if let cgImage = CGWindowListCreateImage(screenFrame, .optionAll, kCGNullWindowID, .nominalResolution) {
            let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
            return bitmapRep.representation(using: .jpeg, properties: [:])
        }
        return nil
    }
    
    private func currentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }

    private func writeTextToFile(jpegData: Data) {
        let base64String = jpegData.base64EncodedString()
        let stringToSave = "\(currentTimestamp()): \(base64String)\n"
        let url = URL.documentsDirectory.appending(path: "screenshots.txt")
        
        let fileManager = FileManager.default

        if fileManager.fileExists(atPath: url.relativePath) {
            // If file exists, append text to it
            if let fileHandle = FileHandle(forWritingAtPath: url.relativePath) {
                fileHandle.seekToEndOfFile()
                if let data = stringToSave.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            }
        } else {
            // If file does not exist, create it and write text
            do {
                try stringToSave.write(toFile: url.relativePath, atomically: true, encoding: .utf8)
            } catch {
                print("Error writing to file: \(error)")
            }
        }
    }
}
