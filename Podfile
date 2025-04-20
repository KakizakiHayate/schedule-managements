platform :ios, '16.0'

target 'ScheduleManagements' do
  use_frameworks! :linkage => :static

  pod 'SwiftLint'
  pod 'RealmSwift', '10.43.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Realm', 'RealmSwift'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end
