class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  { modern: 
  {
    safari: 17.2,
    chrome: 120,
    firefox: 121,
    opera: 106,
    ie: false
  }
}
end
