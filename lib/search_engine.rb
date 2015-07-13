module SearchEngine
  mattr_accessor :configuration
  mattr_accessor :term

  def self.configure_search(options)
    self.configuration = options
  end

  def self.search(term)
  	self.term = term
  end

  def self.like_query
  	query = ""
  	#query+="%#{term}% "
  	term_array = term.split
  	term_array.each_with_index do |element,index|
  	  query +=" OR " if index.zero?
  	  query+="options[:column]} like "
  	  query+="%#{element}%"
  	end
  	query
  end
end
