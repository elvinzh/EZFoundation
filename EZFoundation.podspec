Pod::Spec.new do |s| 
 s.name = 'NTESFoundation'
 s.version = '0.8.8'
 s.summary = 'NetEase' 
 s.homepage = 'https://g.hz.netease.com/ntes-onepiece-ios/NTESFoundation' 
 s.license = { :'type' => 'Copyright', :'text' => 'Copyright 2019 NetEase'} 
 s.authors = 'NetEase One Piece Group' 
 s.source  = { :git => 'https://g.hz.netease.com/ntes-onepiece-ios/NTESFoundation.git', :tag => s.version} 
 s.platform = :ios, '8.0' 

 s.public_header_files = 'NTESFoundation/NTESFoundation.h'
 s.source_files = 'NTESFoundation/NTESFoundation.h'


 s.subspec 'Category' do |ss|
 	ss.source_files = 'NTESFoundation/Category/*.{h,m,mm}'
 end

  s.subspec 'Toolkit' do |ss|
 	ss.source_files = 'NTESFoundation/Toolkit/**/*.{h,m,mm}'

 	ss.dependency 'FMDB', '~> 2.7.2'
 	ss.dependency 'Reachability', '~> 3.2'

 	ss.dependency 'NTESFoundation/Category'
 end

 s.subspec 'Network' do |ss|
 	ss.source_files = 'NTESFoundation/Network/**/*.{h,m,mm}'
 	ss.dependency 'NTESFoundation/Toolkit'
 end

 s.subspec 'Service' do |ss|
 	ss.source_files = 'NTESFoundation/Service/*.{h,m,mm}'
 	ss.dependency 'NTESFoundation/Toolkit'
 end

 s.subspec 'Storage' do |ss|
 	ss.source_files = 'NTESFoundation/Storage/*.{h,m,mm}'
 	ss.dependency 'NTESFoundation/Toolkit'
 end

  s.subspec 'UI' do |ss|
 	ss.source_files = 'NTESFoundation/UI/**/*.{h,m,mm}'
	ss.dependency 'NTESFoundation/Toolkit'
 end


end 
