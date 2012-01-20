require 'spec_helper'

describe SimpleKiss do
  
  module ActionView
    class Base
      include SimpleKiss
    end
  end
   
  before(:all) do
    SimpleKiss::CONFIG = YAML.load(File.open('spec/kissmetrics.yml'))
  end
   
  before(:each) do
    @view = ActionView::Base.new
  end
  
  describe "#api_code" do
    
    it "returns the js code with the key" do
      @view.api_code.should include "_kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/dumbapikey.1.js');"
    end
    
  end
  
  describe "#api_key" do
    
    it "returns the api_key" do
      @view.api_key.should == 'dumbapikey'
    end
    
  end
  
  describe "#kissmetrics" do
    
    context "given that the action and controller are set on the config file" do
      
      around(:each) do |example|
        oldconfig = SimpleKiss::CONFIG
        SimpleKiss::CONFIG['user'] = {'new' => "Visit signup page",'show' => "Visit Account page"}
        example.run
        SimpleKiss::CONFIG.delete('user')
      end
      
      before(:each) do
        @view.stub(:controller_name) {'user'}
        @view.stub(:action_name) {'show'}
      end
      
      it "returns the complete javascript code with the configured name" do
        js = @view.kissmetrics
        js.should include('<script type="text/javascript">')
        js.should include('var _kmq = _kmq || [];')
        js.should include('_kmq.push([\'record\', Visit Account page]);')
        js.should include('</script>')
      end
      
    end
    
    context "given that the action and controller are not set on the config file" do
      
      before(:each) do
        @view.stub(:controller_name) {'user'}
        @view.stub(:action_name) {'show'}
      end
      
      
      context "and default is on" do
        it "returns the complete javascript code with the default slug" do
          js = @view.kissmetrics
          js.should include('<script type="text/javascript">')
          js.should include('var _kmq = _kmq || [];')
          js.should include('_kmq.push([\'record\', user/show]);')
          js.should include('</script>')
        end
      end
      
      context "and default is off" do
        it "returns a blank string" do
          js = @view.kissmetrics(false).should == ""
        end
      end
      
      
      
    end
    
  end
  
  describe "#identify" do
    
  end
  
  
end