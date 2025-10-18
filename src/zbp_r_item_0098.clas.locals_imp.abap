CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Item RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Item RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Item RESULT result.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Item.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE Item.

    METHODS Discount FOR MODIFY
      IMPORTING keys FOR ACTION Item~Discount RESULT result.

    METHODS SetDiscontinueDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetDiscontinueDate.

    METHODS SetItemID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetItemID.

    METHODS validateCurrency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateCurrency.

    METHODS ValidatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidatePrice.

    METHODS ValidateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidateQuantity.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

  METHOD precheck_delete.
  ENDMETHOD.

  METHOD Discount.
  ENDMETHOD.

  METHOD SetDiscontinueDate.
  ENDMETHOD.

  METHOD SetItemID.
  ENDMETHOD.

  METHOD validateCurrency.
  ENDMETHOD.

  METHOD ValidatePrice.
  ENDMETHOD.

  METHOD ValidateQuantity.
  ENDMETHOD.

ENDCLASS.
