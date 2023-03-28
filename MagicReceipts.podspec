Pod::Spec.new do |s|
s.name = 'MagicReceipts'
s.version = '1.0.0'
s.platform = :ios, '13.0'
s.license = { :type => 'Commercial', :text => 'See https://www.pollfish.com/terms/publisher' }
s.summary = 'Magic Receipts iOS Monetization SDK'
s.description = 'Magic Receipts provides a new interactive monetization format to app developers'
s.homepage = 'https://www.pollfish.com/magic-receipts'
s.author = { 'Pollfish Inc.' => 'support@pollfish.com' }
s.requires_arc = true
s.source = {
    :git => 'https://github.com/pollfish/ios-sdk-magic-receipts.git',
    :tag => s.version.to_s
}
s.frameworks = 'WebKit'
s.weak_frameworks = 'AdSupport'
s.documentation_url = 'https://github.com/pollfish/ios-sdk-magic-receipts'
s.vendored_frameworks = 'MagicReceipts.xcframework'
end
