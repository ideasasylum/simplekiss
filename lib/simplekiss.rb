module SimpleKiss
  def kissmetrics(use_default = true)
    controller_slugs = CONFIG[controller_name]
    slug = controller_slugs[action_name] unless controller_slugs.nil?
    slug ||= "#{controller_name}/#{action_name}" if use_default
    
    (slug) ?
    %(
    <script type="text/javascript">
    var _kmq = _kmq || [];
    #{api_code}
    _kmq.push(['record', #{slug}]);
    #{identify}
    </script>
    ) : ""
  end
  
  def api_code
    %(
    function _kms(u){
      setTimeout(function(){
        var s = document.createElement('script'); var f = document.getElementsByTagName('script')[0]; s.type = 'text/javascript'; s.async = true;
        s.src = u; f.parentNode.insertBefore(s, f);
        }, 1);
      }
      _kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/#{self.api_key}.1.js');)
  end
  
  def api_key
      CONFIG['apikey']
  end
  
  def identify
    return unless CONFIG['identify']
    result = CONFIG['identify'].split(".").inject(self) do |memo,word|
      memo.send(word)
    end
    "_kmq.push(['identify', #{result}]);"
  end
end
