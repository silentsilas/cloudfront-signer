defmodule CloudfrontSigner.SignatureTest do
  use ExUnit.Case, async: true

  @correct_signature """
1c78nQoaTrZhgtyy8QtXb-L~HLVWTkwANZXlAX1eq29DuQknMjqk
ptxNb4v~-g9PGLgYDABWFD4rnjVFe2UjHnjQ0b~Z5v80WEQcxaJ8
OIyrRXe5N6cexIVJZzgHqDYVzr-C81khBtn1wXTkcPr6PfZdtuBE
94Mp-E86VAM4Q9Oixdbt154l2piJogx~PJmU2mNV~Fbw-zQrzn~N
DL94YFOfNER5UulIvuILuNhJ3br36PWFmtlfAm~MjCI3aXEotULy
MjzTW5PhReNcprHNLBzunI4HdAKIkbvcOdxTH2hVzI66YcMLk1x1
OuAPleMN8PtGU69lqFCb4kEBihLTzA__
""" |> String.replace(~r/\s+/, "")

  describe "#signature/2" do
    test "It will compute the correct signature for a policy" do
      policy = %CloudfrontSigner.Policy{resource: "https://cloudfront.domain.com/some/path", expiry: 1527884313}
      distribution = CloudfrontSigner.Distribution.from_config(:cloudfront_signer, CloudfrontSignerTest)
      
      assert CloudfrontSigner.Signature.signature(policy, distribution.private_key) == @correct_signature
    end
  end
end