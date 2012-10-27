Gem::Specification.new do |s|
	s.name = "formprocessor"
	s.summary = "Process web forms and have the results emailed to you."
	s.description = File.read(File.join(File.dirname(__FILE__), 'README'))
	s.requirements = [ 'An SMTP server on localhost' ]
	s.version = "0.0.1"
	s.author = "Kenton Small"
	s.email = "kentonthegreat@gmail.com"
	s.homepage = "http://www.kentonsmall.com"
	s.platform = Gem::Platform::RUBY
	s.required_ruby_version = '>=1.9'
	s.files = Dir['lib/*.rb']
	s.has_rdoc = true
end