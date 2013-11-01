module PdfSpec # :nodoc:
  module Matchers # :nodoc:
    # Class that conforms to RSpec specifications for matchers
    #
    # @param [String] pdf_data PDF content as a Ruby string
    class IdenticalPdfs
      def initialize(pdf_data)
        @expected_pages = pdf_to_pixel_pages(pdf_data)
      end

      # Compares given PDF data against
      #
      # @param [String] pdf_data PDF content as a Ruby string
      def matches?(pdf_data)
        @target_pages = pdf_to_pixel_pages(pdf_data)
        @target_pages == @expected_pages
      end

      def failure_message # :nodoc:
        "expected #{@target_pages.inspect} to look the same as #{@expected_pages.inspect}"
      end

      def negative_failure_message # :nodoc:
        "expected #{@target_pages.inspect} not to look the same as #{@expected_pages.inspect}"
      end

      # Get array of page pixels. The first level array represents PDF pages,
      # the second level array - pixels.
      #
      # @param [String] binary string that represents pdf
      #
      # @return [Array<Array<Integer>>] array of arrays of pixels
      def pdf_to_pixel_pages(pdf_data)
        Magick::ImageList.new.
          from_blob(pdf_data).
          remap { |page| page.export_pixels }
      end
      private :pdf_to_pixel_pages
    end

    # Compares the pixel by pixel appearance of two strings of PDF data
    #
    # @param [String] expected The expected PDF file contents
    def have_same_pdf_appearance_as(expected)
      IdenticalPdfs.new(expected)
    end
  end
end
