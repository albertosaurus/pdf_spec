module PdfSpec # :nodoc:
  module Matchers # :nodoc:
    # Class that conforms to RSpec specifications for matchers
    #
    # @param [String] pdf_data PDF content as a Ruby string
    class IdenticalPdfs
      def initialize(pdf_data)
        @expected_pages = parse_pdf_pages(pdf_data)
      end

      # Compares given PDF data against
      #
      # @param [String] pdf_data PDF content as a Ruby string
      def matches?(pdf_data)
        @target_pages = parse_pdf_pages(pdf_data)

        # If the two pdfs have a different number of pages, there's no point
        # in further comparisons.
        return false unless @target_pages.size == @expected_pages.size

        [].tap do |results|
          @expected_pages.each_with_index do |expected_page, i|
            results << (expected_page.pixels.to_s == @target_pages[i].pixels.to_s)
          end
        end.all?
      end

      def failure_message # :nodoc:
        "expected #{@target_pages.inspect} to look the same as #{@expected_pages.inspect}"
      end

      def negative_failure_message # :nodoc:
        "expected #{@target_pages.inspect} not to look the same as #{@expected_pages.inspect}"
      end

      # Wraps a string in a tempfile long enough to be converted to an array of
      # Pixbuf objects representing the PDF pages
      def parse_pdf_pages(pdf_data)
        wrap_in_tempfile(pdf_data) do |pdf_file|
          pdf_to_buffers(pdf_file.path)
        end
      end
      private :parse_pdf_pages

      # Wraps given data in a tempfile as Document takes a path
      #
      # @note This is done this way because the examples were done this way. The API
      # for Poppler::Document.new may take other arguments.
      def wrap_in_tempfile(pdf_data)
        temp = Tempfile.new("pdf_data")
        temp.write pdf_data
        temp.rewind
        yield temp
      ensure
        temp.close
        temp.unlink
      end
      private :wrap_in_tempfile

      # Renders a PDF with RMagick to set of Pixbuf objects (for each page) via
      # Cairo. This is a simplified copy of an example in the samples directory in
      # the poppler gem.
      def pdf_to_buffers(path)
        buffers = []
        pdf     = Magick::ImageList.new(path)

        pdf.each do |page|
          begin
            temp = Tempfile.new(["pdf_page", ".png"])
            page.write(temp.path)
            buffers << Gdk::Pixbuf.new(temp.path)
          ensure
            temp.close
            temp.unlink
          end
        end

        buffers
      end
      private :pdf_to_buffers
    end

    # Compares the pixel by pixel appearance of two strings of PDF data
    #
    # @param [String] expected The expected PDF file contents
    def have_same_pdf_appearance_as(expected)
      IdenticalPdfs.new(expected)
    end
  end
end
