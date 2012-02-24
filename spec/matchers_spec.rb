require 'spec_helper'

module PdfSpec
  module Matchers
    describe "IdenticalPdfs" do
      describe "matches?" do
        it "should be true for matching pdfs" do
          path = "#{FIXTURES}/one.pdf"
          first_pdf = File.read("#{FIXTURES}/one.pdf")
          second_pdf = File.read("#{FIXTURES}/one.pdf")

          matcher = IdenticalPdfs.new(first_pdf)
          matcher.matches?(second_pdf).should be_true
        end

        it "should be false for differing pdfs" do
          first_pdf = File.read("#{FIXTURES}/one.pdf")
          second_pdf = File.read("#{FIXTURES}/two.pdf")

          matcher = IdenticalPdfs.new(first_pdf)
          matcher.matches?(second_pdf).should be_false
        end
      end
    end
  end
end
