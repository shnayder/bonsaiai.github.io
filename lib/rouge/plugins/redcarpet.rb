# this file is not require'd from the root.  To use this plugin, run:
#
#    require 'rouge/plugins/redcarpet'

# this plugin depends on redcarpet
require 'redcarpet'

# stdlib
require 'cgi'

module Rouge
  module Plugins
    module Redcarpet
      def block_code(code, language)
        name, opts = language.split('?')

        # parse the options hash from a cgi-style string
        opts = CGI.parse(opts || '').map do |k, vals|
          [ k.to_sym, vals.empty? ? true : vals[0] ]
        end

        opts = Hash[opts]

        lexer_class = case name
        when 'guess', nil
          lexer = Lexer.guess(:source => code, :mimetype => opts[:mimetype])
        when String
          Lexer.find(name)
        end || Lexers::Text

        lexer = lexer_class.new(opts)
        formatter = Formatters::HTML.new(:css_class => "highlight #{lexer_class.tag}")

        Rouge.highlight(code, lexer, formatter)
      end
    end
  end
end
