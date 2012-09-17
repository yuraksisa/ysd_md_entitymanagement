Gem::Specification.new do |s|
  s.name    = "ysd_md_entitymanagement"
  s.version = "0.2.0"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-08-17"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb']
  s.summary = "Yurak Sisa entity management extensions"
  s.homepage = "http://github.com/yuraksisa/ysd_md_entitymanagement"
    
  s.add_runtime_dependency "data_mapper", "1.1.0"
  
  s.add_runtime_dependency "ysd_core_plugins"
  s.add_runtime_dependency "ysd_md_configuration"
  
end
