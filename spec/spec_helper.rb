require 'pdf_spec'

FIXTURES = File.expand_path("../fixtures", __FILE__)

RSpec.configure do |config|
  config.include(PdfSpec::Matchers)
end
