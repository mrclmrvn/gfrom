require 'spec_helper'

require 'gfrom'

describe Gfrom do
  describe "instance" do
    context "missing required parameter" do
      it "raises exception" do
        expect {
          Gfrom.new
        }.to raise_exception
      end
    end
    context "attributes" do
      before do
        @url = "https://testdocs.google.com/forms/d/1GkTDyoRCGTYXHy5kt2TDwtpr63H0b8Zyd_SWaBHwl30/viewform?hl=en"
        stub_request(:get, @url).to_return(:body => File.open("spec/support/gfrom/form_default.html").read)
      end
      subject { Gfrom.new(@url) }
      it { should respond_to(:fields) }
      it { should respond_to(:form) }
    end

    describe "#submit" do
      context "success" do
        pending
      end
      context "error" do
        pending
      end
    end
  end

  describe "Gfrom::local_url" do
    it "ensures 'lang' is appended" do
      url = "http://www.google.com/"
      Gfrom::locale_url(url, "tl").should =~ /hl=tl/
    end
    it "keeps 'lang' if already set" do
      url = "http://www.google.com/somepath?hl=en"
      Gfrom::locale_url(url, "en").should =~ /hl=en/
    end
    context "require scheme and host" do
      it { expect{ Gfrom::locale_url("domain.com", "en") }.to raise_exception }
      it { expect{ Gfrom::locale_url("http://", "en") }.to raise_exception }
      it { expect{ Gfrom::locale_url("/onlypath", "en") }.to raise_exception }
      it { expect{ Gfrom::locale_url("?foo=bar", "en") }.to raise_exception }
    end
  end
end
