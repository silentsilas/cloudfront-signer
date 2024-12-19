defmodule CloudfrontSigner.Signature do
  @moduledoc """
  Manages policy signing
  """
  alias CloudfrontSigner.Policy

  @doc """
  Converts a `Policy.t` struct to a cloudfront signature for the given private key
  """
  @spec signature(Policy.t(), tuple) :: binary
  def signature(%Policy{} = policy, private_key) do
    to_string(policy)
    |> sign(private_key)
    |> Base.encode64()
    |> String.to_charlist()
    |> Enum.map(&replace/1)
    |> to_string()
  end

  # Unsure why, but needed to prehash the policy before signing
  # Instead of letting :public_key/sign directly handle hashing to get around a bug
  defp sign(
         policy,
         private_key
       ) do
    :public_key.sign(
      :crypto.hash(:sha, policy),
      :none,
      private_key
    )
  end

  @compile {:inline, replace: 1}
  defp replace(?+), do: ?-
  defp replace(?=), do: ?_
  defp replace(?/), do: ?~
  defp replace(c), do: c
end
