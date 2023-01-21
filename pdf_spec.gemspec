# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pdf_spec/version"

Gem::Specification.new do |s|
  s.name        = "pdf_spec"
  s.version     = PdfSpec::VERSION
  s.authors     = ["TMX Credit", "Zachary Belzer", "Sergey Potapov", "Arthur Shagall"]
  s.email       = ["rubygems@tmxcredit.com", "zbelzer@gmail.com", "blake131313@gmail.com", "arthur.shagall@gmail.com"]
  s.homepage    = "https://github.com/albertosaurus/pdf_spec"
  s.licenses    = ["LICENSE"]
  s.summary     = %q{RSpec matchers for comparing PDF files}
  s.description = %q{This library includes matchers that use Poppler and Cairo
    to render PDF files as images and compare them by the pixel}

  s.rubyforge_project = "pdf_spec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", '~> 3.1'
  s.add_development_dependency "rake"

  s.add_runtime_dependency "rmagick", "~> 2.13.0"
end
