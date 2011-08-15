module SpecSupport
  def visit_html(html)
    File.open('public/_test.html', 'w') do |f|
      f.write(html)
    end
    visit('/_test.html')
  end
  
  def show_topic(site_key, topic_key, options = {})
    pre_js    = options[:pre_js]
    topic_url = options[:topic_url]
    
    visit_html(%Q^
      <div id="comments"></div>
      <script type="text/javascript" class="juvia">
      #{pre_js}
      (function() {
        var container   = '#comments';
        var site_key    = '#{site_key}';
        var topic_key   = '#{topic_key}';
        var topic_url   = #{topic_url ? "'#{topic_url}'" : "location.href"};
        var topic_title = document.title || topic_url;
        
        var s       = document.createElement('script');
        s.async     = true;
        s.type      = 'text/javascript';
        s.className = 'juvia';
        s.src = '/api/show_topic.js' +
	        '?container=' + encodeURIComponent(container) +
	        '&site_key=' + encodeURIComponent(site_key) +
	        '&topic_key=' + encodeURIComponent(topic_key) +
	        '&topic_url=' + encodeURIComponent(topic_url) +
          '&topic_title=' + encodeURIComponent(topic_title);
        (document.getElementsByTagName('head')[0] ||
         document.getElementsByTagName('body')[0]).appendChild(s);
      })();
      </script>
    ^)
  end
end
