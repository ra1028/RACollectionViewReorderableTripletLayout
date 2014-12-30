Pod::Spec.new do |s|
  s.name         = "RACollectionViewReorderableTripletLayout"
  s.version      = "0.1.0"
  s.summary      = "The custom collectionView layout that can perform reordering of cells by dragging it."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/ra1028"
  s.author       = { "ra1028" => "r.fe51028.r@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/ra1028/RACollectionViewReorderableTripletLayout.git", :tag => "0.1.0" }
  s.requires_arc = true
  s.source_files =  'RACollectionViewReorderableTripletLayout/*.{h,m}'
end