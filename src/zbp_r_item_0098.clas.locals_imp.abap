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
    METHODS SetReleaseDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetReleaseDate.
    METHODS ValidateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidateName.

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

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
           ENTITY Item
           FIELDS ( DiscontinueDate ) WITH
           CORRESPONDING #( keys )
           RESULT DATA(dates).

    DELETE dates WHERE DiscontinueDate IS NOT INITIAL.

    IF dates IS NOT INITIAL.

      MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
             ENTITY Item
             UPDATE FIELDS ( DiscontinueDate )
             WITH VALUE #( FOR date IN dates INDEX INTO i
                         ( %tky            = date-%tky
                           DiscontinueDate = cl_abap_context_info=>get_system_date( ) + 365 ) ).

    ELSE.

      RETURN.

    ENDIF.

  ENDMETHOD.

  METHOD SetItemID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
          ENTITY Item
          FIELDS ( ItemID ) WITH
          CORRESPONDING #( keys )
          RESULT DATA(Items).

    DELETE Items WHERE ItemID IS NOT INITIAL.

    IF Items IS INITIAL.
      RETURN.
    ENDIF.

    SELECT SINGLE FROM zcds_r_item_0098
      FIELDS MAX( ItemID ) AS MaxItemID
      INTO @DATA(max_ItemID).

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
           ENTITY Item
           UPDATE FIELDS ( ItemID )
           WITH VALUE #( FOR Item IN Items INDEX INTO i
                         ( %tky     = Item-%tky
                           ItemID = max_ItemID + i ) ).



  ENDMETHOD.

  METHOD validateCurrency.
  ENDMETHOD.

  METHOD ValidatePrice.

    DATA Price TYPE SORTED TABLE OF zcds_r_item_0098 WITH UNIQUE KEY HeaderUUID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( Price ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Prices).

    Price = CORRESPONDING #( Prices DISCARDING DUPLICATES MAPPING HeaderUUID = HeaderUUID Price = Price EXCEPT * ).

    LOOP AT Prices ASSIGNING FIELD-SYMBOL(<fs_price>).

      IF line_exists( Price[ HeaderUUID = <fs_price>-HeaderUUID ] ).

        IF <fs_price>-price IS INITIAL OR <fs_price>-price <= 0.

          APPEND VALUE #( %tky = <fs_price>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #( %tky           = <fs_price>-%tky
                          %state_area    = 'VALIDATE_PRICE'
                          %element-price = if_abap_behv=>mk-on
                          %msg           = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_price
                                                                    severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          RETURN.

        ENDIF.

      ELSE.

        APPEND VALUE #( %tky = <fs_price>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #( %tky           = <fs_price>-%tky
                        %state_area    = 'VALIDATE_PRICE'
                        %element-price = if_abap_behv=>mk-on
                        %msg           = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_price
                                                                  severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateQuantity.
  ENDMETHOD.

  METHOD SetReleaseDate.
  ENDMETHOD.

  METHOD ValidateName.
  ENDMETHOD.

ENDCLASS.
