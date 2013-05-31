Pod::Spec.new do |s|
  s.name         = "Base64"
  s.version      = "1.1"
  s.summary      = "Base64 is a set of categories that provide methods to encode and decode data as a base-64-encoded string."
  s.homepage     = "https://github.com/nicklockwood/Base64/"
  s.license      = "Unknown"
  s.author       = { "Nick Lockwood" => "support@charcoaldesign.co.uk" }
  s.source       = { :git => "https://github.com/nicklockwood/Base64.git", :tag => "1.1" }
  s.source_files = 'Base64/**/*.{h,m}'
  s.requires_arc = true
end
