class GroupMembershipsController < ApplicationController
  def index
    @contacts = find_contactable
    render json: @contacts.memberships
  end

  private

    def find_contactable
      params.each do |k,v|
        if k =~ /(.+)_id$/
          return $1.classify.constantize.find(v)
        end
      end
      nil
    end
end
