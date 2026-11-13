import AppKit
import PDFKit

guard (2...3).contains(CommandLine.arguments.count),
      let pdf = PDFDocument(url: URL(fileURLWithPath: CommandLine.arguments[1])),
      !pdf.isLocked else { exit(1) }

if CommandLine.arguments.count == 3 {
    guard let index = Int(CommandLine.arguments[2]), index >= 0, index < pdf.pageCount,
          let page = pdf.page(at: index) else { exit(1) }
    let image = page.thumbnail(of: NSSize(width: 1400, height: 1800), for: .cropBox)
    guard let tiff = image.tiffRepresentation,
          let png = NSBitmapImageRep(data: tiff)?.representation(using: .png, properties: [:])
    else { exit(1) }
    FileHandle.standardOutput.write(png)
} else {
    let pages = (0..<pdf.pageCount).map { pdf.page(at: $0)?.string ?? "" }
    FileHandle.standardOutput.write(try JSONEncoder().encode(pages))
}
