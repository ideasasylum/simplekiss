module SimpleKiss
  def kissmetrics(use_default = true)
    slug = CONFIG[controller_name][action_name]
    slug ||= "#{controller_name}/#{action_name}" if use_default
    apikey = CONFIG['apikey'] #"f07d00f8f9e6049d5c106a14612fa1614d4f3d40"

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
