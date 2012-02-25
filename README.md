PdfSpec
-------

PdfSpec includes rspec matchers to compare the appearance of PDF files.
This is obviously most useful when you need to verify that you can produce
a PDF that looks identical to a sample PDF file.

# Installation

This library depends on the `poppler` ruby gem which internally relies on
the poppler library for rendering PDFs. Poppler itself has many dependent
libraries and thus this gem does as well.

## Homebrew

    brew install gtk+
    brew install pango
    brew install gdk-pixbuf
    brew install atk
    brew install poppler

## Debian (Ubuntu)

    apt-get install poppler

## Gentoo

    emerge poppler

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
