PdfSpec
-------

PdfSpec includes rspec matchers to compare the appearance of PDF files.
This is obviously most useful when you need to verify that you can produce
a PDF that looks identical to a sample PDF file.

# Installation

This library depends on the `rmagick` ruby gem.

## Homebrew

    brew install imagemagick
    brew install ghostscript

## MacPorts
    sudo port install ImageMagick

## Debian (Ubuntu)

The following was tested on Ubuntu 11.10, 12.04, and 20.04.

    sudo apt-get install libmagickwand-dev

On Ubuntu 20.04 and later, you may run into the following error:

    Magick::ImageMagickError:
       attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/408

To resolve this, edit `/etc/ImageMagick-6/policy.xml`. Change `<policy domain="coder" rights="none" pattern="PDF" />` to `<policy domain="coder" rights="read|write" pattern="PDF" />`.
If that doesn't help, change `<!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->` to `<policy domain="module" rights="read|write" pattern="{PS,PDF,XPS}" />`.

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
