module AccountsHelper

    def profile_picture account, width = 100
        image_path = account.image.present? ? account.image.url : "default.png" 
        image_tag(image_path,width: width, class: "img-circle m-r-10")
    end

    def profile_picture_thumb account, width = 30
        image_path = account.image.present? ? account.image.thumb.url : "default.png" 
        image_tag(image_path,width: width, class: "img-circle m-r-10")
    end

    def can_edit_profile? profile_id
        account_signed_in? && current_account.id == profile_id
    end
end
