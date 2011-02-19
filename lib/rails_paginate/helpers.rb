module RailsPaginate
  # helpers modules
  module Helpers
    autoload :ActionView, 'rails_paginate/helpers/action_view'
    autoload :ActiveRecord, 'rails_paginate/helpers/active_record'
    autoload :DataMapper, 'rails_paginate/helpers/data_mapper'
    autoload :Array, 'rails_paginate/helpers/array'
  end
end