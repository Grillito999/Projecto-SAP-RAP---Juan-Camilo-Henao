CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF ty_order_status,
        rejeccted TYPE n LENGTH 1 VALUE 1,
        open      TYPE n LENGTH 1 VALUE 2,
        approved  TYPE n LENGTH 1 VALUE 3,
      END OF ty_order_status.

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

    METHODS SetHeaderID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~SetHeaderID.

    METHODS SetStatusOpen FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~SetStatusOpen.

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

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
           ENTITY Header
           UPDATE FIELDS ( OrderStatus )
           WITH VALUE #( FOR order IN keys
                         ( %tky        = order-%tky
                           OrderStatus = ty_order_status-approved  ) ).

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( OrderStatus ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Headers).

    result = VALUE #( FOR Header IN Headers
                      ( %tky   = Header-%tky
                        %param = header ) ).

  ENDMETHOD.

  METHOD RejectOrder.

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
            ENTITY Header
            UPDATE FIELDS ( OrderStatus )
            WITH VALUE #( FOR order IN keys
                          ( %tky        = order-%tky
                            OrderStatus = ty_order_status-rejeccted  ) ).

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( OrderStatus ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Headers).

    result = VALUE #( FOR Header IN Headers
                      ( %tky   = Header-%tky
                        %param = header ) ).

  ENDMETHOD.

  METHOD SetHeaderID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Headers).

    DELETE headers WHERE HeaderId IS NOT INITIAL.

    IF headers IS INITIAL.
      RETURN.
    ENDIF.

    SELECT SINGLE FROM zcds_r_header_0098
      FIELDS MAX( HeaderId ) AS MaxHeaderId
      INTO @DATA(max_headerid).

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
           ENTITY Header
           UPDATE FIELDS ( HeaderId )
           WITH VALUE #( FOR header IN headers INDEX INTO i
                         ( %tky     = header-%tky
                           HeaderId = max_headerid + i ) ).

  ENDMETHOD.

  METHOD setstatusopen.

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
