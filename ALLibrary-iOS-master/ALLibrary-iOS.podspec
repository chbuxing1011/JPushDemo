Pod::Spec.new do |s|
s.name = "ALLbrary-iOS"
s.version= "1.7"
s.summary= "A short description of ALLbrary-iOS."
s.homepage = "https://github.com/z306007236/ALLibrary-iOS"
s.license= "MIT"
s.author = { "z306007236" => "306007236@qq.com" }
s.source = { :git => "https://github.com/z306007236/ALLibrary-iOS.git", :tag => "1.7" }
s.source_files = "ALLbrary-iOS/**/*.{h,m}"
s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"
s.dependency "AFNetworking","~>2.4.1"
s.dependency 'Reachability','~>3.1.1'
s.dependency 'SVProgressHUD','~>1.0'
s.dependency 'FMDB','~>2.3'

end
