module PdfSpec
  module Matchers
    class IdenticalPdfs
      def initialize(pdf_data)
        @expected_pages = parse_pdf(pdf_data)
      end

      def matches?(pdf_data)
        target_pages = parse_pdf(pdf_data)

        [].tap do |results|
          @expected_pages.each_with_index do |expected_page, i|
            results << (expected_page.pixels.to_s == target_pages[i].pixels.to_s)
          end
        end.all?
      end

      def parse_pdf(pdf_data)
        wrap_in_tempfile(pdf_data) do |pdf_file|
          pdf_to_buffers(pdf_file.path)
        end
      end

      def wrap_in_tempfile(pdf_data)
        temp = Tempfile.new("pdf_data")
        temp.write pdf_data
        temp.rewind
        yield temp
      ensure
        temp.close
        temp.unlink
      end

      def pdf_to_buffers(path)
        doc = Poppler::Document.new(path)
        doc.map do |page|
          begin
            temp = Tempfile.new("pdf_page")
            surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, page.size[0], page.size[1])

            cr = Cairo::Context.new(surface)
            cr.render_poppler_page(page)
            cr.target.write_to_png(temp.path)
            cr.target.finish

            Gdk::Pixbuf.new(temp.path)
          ensure
            temp.close
            temp.unlink
          end
        end
      end

      def failure_message
        "expected #{@target.inspect} to look the same as #{@expected.inspect}"
      end

      def negative_failure_message
        "expected #{@target.inspect} not to look the same as #{@expected.inspect}"
      end

    end

    def have_same_pdf_appearance_as(expected)
      IdenticalPdfs.new(expected)
    end
  end
end
