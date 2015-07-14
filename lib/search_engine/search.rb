module SearchEngine
  module Search
    mattr_accessor :configuration do
      {
        :column => nil,
        :search_limit => nil
      }
    end
    mattr_accessor :term
    mattr_accessor :model_name

    def self.configure_search(options)
      self.configuration = options
    end

    def self.search(term)
    	self.term = term
      find_query = self.configuration[:sql_query] ? self.configuration[:sql_query] : self.like_query
      order_query = self.configuration[:sql_query] ? "" : self.order_query(term)
      limit_query = self.configuration[:search_limit] ? "LIMIT #{self.configuration[:search_limit]}" : ""
      self.model_name.find_by_sql(find_query+order_query+limit_query)
    end

    def self.like_query
    	query = ""
    	term_array = term.split
      term_array.delete("and")
    	term_array.each_with_index do |element,index|
    	  query +=" OR " unless index.zero?
    	  query+="#{self.configuration[:column]} like "
    	  query+="'%#{element}%'"
    	end
    	query
    end

    def self.order_query(term)
      query = "CASE "
      query1,order = self.when_query(term,0)
      query2,order = self.when_query(term,order)
      query+ query1 + query2 + " else #{order} END ASC"
    end

    def self.when_query(term,order)
      query = ""
      terms = term.split
      order = 0
      if terms.include?("and")
        query += " when title like '#{term}%' then #{order}"
        order +=1
        query += " when title like '%#{term}%' then #{order}"
        order +=1
        query += " when title like '%#{term}' then #{order}"
        order +=1
      end
      terms.delete("and")
      (0..terms.length-1).each do |limit|
        keyword = terms[0..(terms.length-1-limit)].join(' ')
        query += " when title like '#{keyword}%' then #{order}"
        order +=1
        query += " when title like '%#{keyword}%' then #{order}"
        order +=1
        query += " when title like '#{keyword}%' then #{order}"
        order +=1
      end
      [query,order]
    end
  end
end