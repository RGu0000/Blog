class OverrideDevise::RegistrationsController < Devise::RegistrationsController
  def destroy
    super
    if resource.destroy
      UserServices::OrphanArticleDestroyer.call(resource.id)
    end
  end
end
