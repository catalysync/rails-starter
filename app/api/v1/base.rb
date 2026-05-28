module API
  module V1
    class Base < Grape::API
      version "v1", using: :path
    end
  end
end
