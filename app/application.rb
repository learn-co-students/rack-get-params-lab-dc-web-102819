class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      item_search = req.params["item"]
      resp.write item_in_cart?(item_search)

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else 
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def item_in_cart?(item_search)
    if @@items.include?(item_search)
      updated_cart = @@cart << item_search
      updated_cart 
      "added #{item_search}"
    else
      return "We don't have that item"
    end
  end
end
