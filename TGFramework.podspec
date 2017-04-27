Pod::Spec.new do |s|
  s.name         = "TGFramework"
  s.version      = "1.0"
  s.summary      = "Developer friendly library for faster iOS app development"
  s.description  = "Developer friendly library, that can help to improve feature development rather focusing on common structure creation during every mobile app development."
  s.homepage     = "https://github.com/techgrains/TGFramework-iOS"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author       = { "Vishal Patel" => "vishal@techgrains.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/techgrains/TGFramework-iOS.git", :tag => "1.0" }
  s.source_files = "TGFramework/TGFramework/**/*.swift"
end
