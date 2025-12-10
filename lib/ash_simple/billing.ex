defmodule AshSimple.Billing do
  use Ash.Domain

  resources do
    resource AshSimple.Billing.Estimate
  end
end
