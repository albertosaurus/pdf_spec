require 'spec_helper'

module PdfSpec
  module Matchers
    describe "IdenticalPdfs" do
      describe "matches?" do
        let(:fixture_one) { "#{FIXTURES}/one.pdf" }
        let(:fixture_two) { "#{FIXTURES}/two.pdf" }
        let(:fixture_three) { "#{FIXTURES}/two_pages.pdf" }

        it "should be true for matching pdfs" do
          first_pdf = File.read(fixture_one)
          second_pdf = File.read(fixture_one)

          matcher = IdenticalPdfs.new(first_pdf)
          expect(matcher.matches?(second_pdf)).to eq true
        end

        it "should be false for differing pdfs" do
          first_pdf = File.read(fixture_one)
          second_pdf = File.read(fixture_two)

          matcher = IdenticalPdfs.new(first_pdf)
          expect(matcher.matches?(second_pdf)).to eq false
        end

        it "should be false for pdfs with a different number of pages" do
          first_pdf = File.read(fixture_one)
          second_pdf = File.read(fixture_three)

          matcher = IdenticalPdfs.new(first_pdf)
          expect(matcher.matches?(second_pdf)).to eq false
        end
      end
    end
  end
end
