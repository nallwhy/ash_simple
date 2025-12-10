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

  changes do
    change fn changeset, _context ->
      orig_price = changeset |> Ash.Changeset.get_attribute(:original_price)
      discount_price = changeset |> Ash.Changeset.get_attribute(:discount_price)

      final_price =
        case [orig_price, discount_price] |> Enum.any?(&is_nil(&1)) do
          true -> nil
          false -> orig_price - discount_price
        end

      changeset
      |> Ash.Changeset.change_attribute(:final_price, final_price)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :original_price, :integer
    attribute :discount_price, :integer
    attribute :final_price, :integer
  end
end
