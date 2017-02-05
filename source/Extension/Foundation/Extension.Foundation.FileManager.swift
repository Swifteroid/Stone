import Foundation

extension FileManager
{
    public func fileExists(at url: URL) -> Bool {
        return self.fileExists(atPath: url.path)
    }

    public func assureDirectory(at url: URL) throws {
        let path: String = url.path
        var directory: ObjCBool = ObjCBool(false)
        let exists: Bool = self.fileExists(atPath: path, isDirectory: &directory)

        if exists && directory.boolValue {
            return
        } else if exists {
            throw Error.fileAlreadyExists
        }

        try self.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
}

extension FileManager
{
    enum Error: Swift.Error
    {
        case fileAlreadyExists
    }
}