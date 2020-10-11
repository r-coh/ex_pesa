defmodule ExPesa.Mpesa.TransactionStatusTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import Tesla.Mock
  doctest ExPesa.Mpesa.TransactionStatus

  alias ExPesa.Mpesa.TransactionStatus

  setup do
    mock(fn
      %{
        url: "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials",
        method: :get
      } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "access_token" => "SGWcJPtNtYNPGm6uSYR9yPYrAI3Bm",
            "expires_in" => "3599"
          }
        }

      %{
        url: "https://sandbox.safaricom.co.ke/mpesa/transactionstatus/v1/query",
        method: :post
      } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "ConversationID" => "AG_20201010_000056be35a7b266b43e",
            "OriginatorConversationID" => "27288-72545279-2",
            "ResponseCode" => "0",
            "ResponseDescription" => "Accept the service request successfully."
          }
        }
    end)

    :ok
  end

  describe "Mpesa Transaction Status" do
<<<<<<< HEAD
    test "request/1 should Initiate a B2B request" do
      query_details = %{
        occasion: "Some Occasion",
        party_a: "600247",
        identifier_type: "4",
        remarks: "CustomerPayBillOnline",
        transaction_id: "SOME7803"
=======
    test "request/1 should Initiate a TransactionStatus request" do
      query_details = %{
        transaction_id: "SOME7803",
        receiver_party: "600247",
        identifier_type: 4,
        remarks: "CustomerPayBillOnline",
        occasion: "TransactionReversal"
>>>>>>> 0a47c067fdc264fa7ba48dab95c8cc5fca5f1200
      }

      {:ok, result} = TransactionStatus.request(query_details)

      assert result["ResponseDescription"] == "Accept the service request successfully."
    end

    test "request/1 should error out without required parameter" do
<<<<<<< HEAD
      {:error, result} = TransactionStatus.request()

      "Some Required Parameter missing, check whether you have 'occasion', 'party_a', 'identifier_type', 'remarks',  and 'transaction_id'" =
=======
      {:error, result} = TransactionStatus.request({})

      "Some Required Parameter missing, check whether you have 'transaction_id', 'receiver_party', 'identifier_type', 'remarks'" =
>>>>>>> 0a47c067fdc264fa7ba48dab95c8cc5fca5f1200
        result
    end
  end
end
