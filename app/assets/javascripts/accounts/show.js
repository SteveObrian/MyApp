var Show = (function() {
  var $btnNewTransaction;
  var $modalTransaction;
  var $btnSave;
  var $inputAmount;
  var $selectTransactionType;
  var $parameters;
  var $notification;

  var accountId;
  var url = "/api/v1/accounts/new_transaction";

  var fetchElements = function() {
    $btnNewTransaction      = $("#btn-new-transaction");
    $modalTransaction       = $("#modal-transaction");
    $btnSave                = $("#btn-save");
    $inputAmount            = $("#input-amount");
    $selectTransactionType  = $("#select-transaction-type");
    $selectPurpose          = $("#select-purpose");
    $parameters             = $(".parameters");
    $notification           = $(".notification");

    accountId               = $(".parameters").data("account-id");
  };

  var disableControls = function() {
    $btnSave.prop("disabled", true);
    $inputAmount.prop("disabled", true);
    $selectTransactionType.prop("disabled", true);
    $selectPurpose.prop("disabled", true);
  };

  var enableControls = function() {
    $btnSave.prop("disabled", false);
    $inputAmount.prop("disabled", false);
    $selectTransactionType.prop("disabled", false);
    $selectPurpose.prop("disabled", false);
  };

  var initializeEvents = function() {
    $btnNewTransaction.on("click", function() {
      $modalTransaction.modal("show");
    });

    $btnSave.on("click", function() {
      var amount            = $inputAmount.val();
      var transactionType   = $selectTransactionType.val();
      var purpose           = $selectPurpose.val();
      disableControls();

      $notification.html("")

      $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        data: {
          amount: amount,
          transaction_type: transactionType,
          account_id: accountId,
          purpose: purpose
        },
        success: function(response) {
          window.location.href = "/accounts/" + accountId;
        },
        error: function(response) {
          $notification.html(JSON.parse(response.responseText).errors.join());
          enableControls();
        }
      });
    });
  };

  var init = function() {
    fetchElements();
    initializeEvents();
  };

  return {
    init: init
  };
})();
