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
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
        # resp.write @@cart
      end
    elsif req.path.match(/add/)
      search_the_item_to_add_in_cart = req.params["item"]
      resp.write check_if_item_exist(search_the_item_to_add_in_cart)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def check_if_item_exist(search_item)
    if @@items.include?(search_item)
      @@cart << search_item
      return "added #{search_item}"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
