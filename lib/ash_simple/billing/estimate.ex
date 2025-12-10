defmodule AshSimple.Billing.Estimate do
  use Ash.Resource,
    domain: AshSimple.Billing,
    data_layer: Ash.DataLayer.Ets

  code_interface do
    define :create
    define :read
    define :update
    define :destroy
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:original_price, :discount_price, :final_price]
    end

    update :update do
      accept [:original_price, :discount_price, :final_price]
      require_atomic? false
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :original_price, :integer
    attribute :discount_price, :integer
    attribute :final_price, :integer
  end
end
