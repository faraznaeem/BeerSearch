module BeersHelper
  PLACEHOLDER_IMAGE = 'https://images.unsplash.com/photo-1618183479302-1e0aa382c36b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'

  def check_and_display_image(image)
    if image["image_url"].nil?
      image_tag(PLACEHOLDER_IMAGE, width: '150')
    else
      image_tag(image["image_url"], height: '150')
    end
  end
end
