require 'net/smtp'
require_relative 'required'
require_relative 'mailer'
# Process web forms and email the results based on the _values_ Hash (typically cgi.params).
module FormProcessor
	# The gem's logic handler.
	class Main
		# Result of the form submission after processing. Contains error String or nil if no errors.
		attr_reader :result
		# Expects a Hash such as _cgi.params_
		def initialize(values)
			@values = values
			@result = String.new
			@email_output = String.new
			setup
			run
		end
		private
		def setup
			@values.each do |key,val|
				if val.is_a? Array then temp = val.join(', '); val, @values[key] = temp, temp end
				temp = val.gsub(%r{</?[^>]+?>},'').strip; val, @values[key] = temp, temp
				@email_output += key.capitalize + ': ' + val + '<br />'
			end
		end
		def run
			if @values.has_key? 'required' then @result = Required.new(@values).result end
			if @values.has_key? 'mailto' and @result.length == 0 then Mailer.new(@values,@email_output) end
			if @values.has_key? 'redirect' and @result.length == 0
				puts '<meta http-equiv="refresh" content="0;url=' + @values['redirect'] + '">'
				exit
			end
			if @result.length == 0 then @result = nil end
		end
	end
end