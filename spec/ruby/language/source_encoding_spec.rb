require_relative '../spec_helper'

describe "Source files" do
  
  describe "encoded in UTF-8 without a BOM" do
    it "can be parsed" do
      ruby_exe(fixture(__FILE__, "utf8-nobom.rb"), args: "2>&1").should == "hello\n"
    end
  end
  
  describe "encoded in UTF-8 with a BOM" do
    it "can be parsed" do
      ruby_exe(fixture(__FILE__, "utf8-bom.rb"), args: "2>&1").should == "hello\n"
    end
  end
  
  describe "encoded in UTF-16 LE without a BOM" do
    it "are parsed because empty as they contain a NUL byte before the encoding comment" do
      ruby_exe(fixture(__FILE__, "utf16-le-nobom.rb"), args: "2>&1").should == ""
    end
  end
  
  describe "encoded in UTF-16 LE with a BOM" do
    it "are invalid because they contain an invalid UTF-8 sequence before the encoding comment" do
      ruby_exe(fixture(__FILE__, "utf16-le-bom.rb"), args: "2>&1").should =~ /invalid multibyte char/
    end
  end
  
  describe "encoded in UTF-16 BE without a BOM" do
    it "are parsed as empty because they contain a NUL byte before the encoding comment" do
      ruby_exe(fixture(__FILE__, "utf16-be-nobom.rb"), args: "2>&1").should == ""
    end
  end
  
  describe "encoded in UTF-16 BE with a BOM" do
    it "are invalid because they contain an invalid UTF-8 sequence before the encoding comment" do
      ruby_exe(fixture(__FILE__, "utf16-be-bom.rb"), args: "2>&1").should =~ /invalid multibyte char/
    end
  end
  
end
