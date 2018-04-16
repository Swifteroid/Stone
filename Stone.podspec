Pod::Spec.new do |spec|
  spec.name = 'Stone'
  spec.version = '0.1.3'
  spec.summary = 'Swift extension and utility collection for happy everyday coding 😌'
  spec.license = { :type => 'MIT' }
  spec.homepage = 'https://github.com/swifteroid/stone'
  spec.authors = { 'Ian Bytchek' => 'ianbytchek@gmail.com' }

  spec.platform = :osx, '10.11'

  spec.source = { :git => 'https://github.com/swifteroid/stone.git', :tag => "#{spec.version}" }
  spec.source_files = 'source/**/*.{swift,h,m}'
  spec.exclude_files = 'source/Test'
  spec.swift_version = '4'

  spec.pod_target_xcconfig = { 'OTHER_SWIFT_FLAGS[config=Release]' => '-suppress-warnings' }
end