CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE Header.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Header.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE Header.

    METHODS ApproveOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~ApproveOrder RESULT result.

    METHODS RejectOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~RejectOrder RESULT result.

    METHODS SetCreateOn FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~SetCreateOn.

    METHODS SetHeaderID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~SetHeaderID.

    METHODS ValidateCountry FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateCountry.

    METHODS ValidateDeliveryDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateDeliveryDate.

    METHODS ValidateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateEmail.

    METHODS ValidateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateName.

    METHODS ValidateOrderStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateOrderStatus.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

  METHOD precheck_delete.
  ENDMETHOD.

  METHOD ApproveOrder.
  ENDMETHOD.

  METHOD RejectOrder.
  ENDMETHOD.

  METHOD SetCreateOn.
  ENDMETHOD.

  METHOD SetHeaderID.
  ENDMETHOD.

  METHOD ValidateCountry.
  ENDMETHOD.

  METHOD ValidateDeliveryDate.
  ENDMETHOD.

  METHOD ValidateEmail.
  ENDMETHOD.

  METHOD ValidateName.
  ENDMETHOD.

  METHOD ValidateOrderStatus.
  ENDMETHOD.

ENDCLASS.
