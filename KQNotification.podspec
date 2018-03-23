Pod::Spec.new do |s|
s.name             = 'KQNotification'
s.version          = '1.0'
s.summary          = 'Local Notification - Create local, daily, weekly notifications.'

s.description      = <<-DESC
A Swift class which helps you create local, daily, weekly notifications and add actions for user notification easily.
DESC

s.homepage         = 'https://github.com/quockhai/KQNotification'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Quoc Khai' => 'quockhai.vn@gmail.com' }
s.source           = { :git => 'https://github.com/quockhai/KQNotification.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = 'KQNotification/Source/KQNotification.swift'
s.swift_version = '4.0'

end
