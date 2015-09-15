module ContactsHelper
  private
    def contact_params
      params.require(:contact).permit(:user_id, :email, :name, :favorited)
    end
end
