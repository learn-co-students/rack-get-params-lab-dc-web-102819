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
  # search route to be able to search things
    elsif req.path.match(/cart/) 
      if @@cart.empty?
        resp.write "Your cart is empty."
      else
        @@cart.each do |item|
        resp.write "#{item}\n"
          end
  # cart route -- if cart is empty, message given.
  # If cart has the item, the item is shown listed.
      end
    elsif req.path.match(/add/)
      add_to_cart = req.params["item"]
      if @@items.include? add_to_cart 
        @@cart << add_to_cart
        resp.write "added #{add_to_cart}"
      else
        resp.write "We don't have that item!"
  # add route -- takes in a GET param ("item")
  # if item exists in @@items, it's added to the cart.
  # if item is not in @@items, a message is returned.
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

end
