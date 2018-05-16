class OverrideDevise::RegistrationsController < Devise::RegistrationsController
  def destroy
    ApplicationRecord.transaction do
      UserServices::UserAndAssociationsDestroyer.call(resource.id)
      TagServices::OrphanTagDestroyer.call
      super
    end
  end
end
