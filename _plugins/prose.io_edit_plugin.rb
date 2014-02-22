# RenderProseIOEditLinkTag
# 
# This is a simple Liquid template tag that can be used in Jekyll
# sites to generate a link to a prose.io edit URL. It should be placed
# in Jekyll's _plugin directory and it will automatically be registered.
#
# A few configuration elements need to be defined in Jekyll's _config.yml
#  - repo_name -- the name of the GitHub repository you're working with
#  - org_name -- the GitHub organization (or user) account name
#  - branch -- the default branch you're working from; e.g., master, gh-pages, etc.
#
#  This is an optional element
#  - prose_url -- the main prose edit site. Default: http://prose.io
#

# Only for debug
# require 'pp'

module Jekyll
  class RenderProseIOEditLinkTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)

      # Grab the all the configuration elements we need
      @conf = context.registers[:site].config
      @page = context.registers[:page]
      @current_page_path = @page['path']
      
      # The main URL we'll build and render at the end
      @url = ''

      # Custom fields that must be defined in _config.yml
      # Prose site. Default: prose.io
      @prose = @conf['prose_url'] ? @conf['prose_url'] : 'http://prose.io'
      #@prose = 'http://prose.io' unless @prose==nil

      # The GitHub repo name
      @repo = @conf['repo_name'] ? @conf['repo_name'] : 'Specify repo_name in _config.yml'
      #@repo = 'Specify repo_name in _config.yml' unless @repo

      @org = @conf['org_name'] ? @conf['org_name'] : 'Specify org_name in _config.yml'
      #@org = 'Specify org_name in _config.yml' unless @org==nil

      @branch = @conf['branch'] ? @conf['branch'] : "Specify branch (master, gh-pages) in _config.yml"

      # Build the URL
      @url = "#{@prose}/##{@org}/#{@repo}/edit/#{@branch}/#{@current_page_path}"

      # Render the edit URL
      "#{@url}"
      
      # This dumps the configuration in what appears to be ~once per rendered page in the _site
      # PP.pp(@page)

    end
  end
end

Liquid::Template.register_tag('render_prose_url', Jekyll::RenderProseIOEditLinkTag)

