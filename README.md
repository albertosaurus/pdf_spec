PdfSpec
-------

PdfSpec includes rspec matchers to compare the appearance of PDF files.
This is obviously most useful when you need to verify that you can produce
a PDF that looks identical to a sample PDF file.

# Installation

This library depends on the `pixbuf2` and `rmagick` ruby gems which internally relies on
appropriate system packets.

## Homebrew

    brew install imagemagick
    brew install ghostscript

## MacPorts
    sudo port install ImageMagick

## Debian (Ubuntu)

The following was tested on Ubuntu 11.10 and 12.04.

    sudo apt-get install libmagickwand-dev

## (TODO) Gentoo

    # Install libmagickwand

# Use

To use the matchers in your tests, simple include the Matchers module into RSpec:

    RSpec.configure do |config|
      config.include(PdfSpec::Matchers)
    end

Or include it in certain tests:

    describe "Testing PDFs" do
      include PdfSpec::Matchers

      it "should match..."; end
    end

Matchers contains the `have_same_pdf_appearance_as` expectation which will render
out PDF files to pixel buffers in memory and then compare them pixel by pixel.


    it "should be the same PDF" do
      source_pdf = File.read("path/to/source")
      expected_pdf = File.read("path/to/expected")

      source.should have_same_pdf_appearance_as(expected_pdf)
    end
