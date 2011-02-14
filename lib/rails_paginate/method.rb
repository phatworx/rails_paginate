module RailsPaginate
  # method modules
  module Method
    autoload :Base, 'rails_paginate/method/base'
    autoload :Jumping, 'rails_paginate/method/jumping'
    autoload :Sliding, 'rails_paginate/method/sliding'
  end
end