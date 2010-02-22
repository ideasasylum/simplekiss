module SimpleKiss
  def kissmetrics(use_default = true)
    controller_slugs = CONFIG[controller_name]
    slug = controller_slugs[action_name] unless controller_slugs.nil?
    slug ||= "#{controller_name}/#{action_name}" if use_default
    apikey = CONFIG['apikey']

    (slug) ?
"   <script type=\"text/javascript\">
      var KM_KEY = \"#{apikey}\";
      document.write(unescape(\"%3Cscript src='\" + ((\"https:\" == document.location.protocol) ? \"https://s3.amazonaws.com/\" : \"http://\") + \"scripts.kissmetrics.com/t.js' type='text/javascript'%3E%3C/script%3E\"));
    </script>
    <script type=\"text/javascript\">
      KM.record(\"#{slug}\")
    </script>
    " : ""
  end
end
