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

## MacPorts
    sudo port install cairo +x11 # note, no +universal.  This caused segfault for me on 10.6.8 --mike 20120725
    sudo port install gtk2 +universal +x11
    sudo port install gdk-pixbuf2 +universal
    sudo port install poppler +universal

## Debian (Ubuntu)

The following was tested on Ubuntu 11.10 and 12.04.

    sudo apt-get install libglib2.0-dev libatk1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libgtk2.0-dev libpoppler-glib-dev

## (TODO) Gentoo

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
