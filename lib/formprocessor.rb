require 'net/smtp'
require_relative 'required'
require_relative 'mailer'
# Process web forms based on the "values" Hash (typically cgi.params).
# = Example Usage
#	#!/usr/bin/ruby
#	require 'cgi'
#	require 'formprocessor'
#	cgi = CGI.new
#	puts cgi.header
#	puts FormProcessor::Main(cgi.params).result
# = Keywords
# * _required_
#		A CSV string. Check for the existence of these form fields.
# * _mailto_
#		If successful submission, mail results to this address. A valid SMTP server running on localhost is required.
# * _redirect_
#		Redirect to this URL upon successful submission.
# = Return Values & Templating
#	It is possible to template the results of the form submission by omitting the redirection key/value pair in the values Hash.
#	If there are no errors, result will return nil. If there are errors, result will return a String containing those errors.
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