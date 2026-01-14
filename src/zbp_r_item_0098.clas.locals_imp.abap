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

    METHODS SetItemID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetItemID.

    METHODS SetReleaseDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetReleaseDate.

    METHODS SetDiscontinueDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~SetDiscontinueDate.

    METHODS validateCurrency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateCurrency.

    METHODS ValidatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidatePrice.

    METHODS ValidateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidateQuantity.

    METHODS ValidateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~ValidateName.

    METHODS Discount FOR MODIFY
      IMPORTING keys FOR ACTION Item~Discount RESULT result.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
          ENTITY Item
          FIELDS ( Price ) WITH CORRESPONDING #( keys )
          RESULT DATA(Prices).

    result = VALUE #( FOR price IN Prices
                      ( %tky                 = price-%tky
                        %action-Discount = COND #(  WHEN price-Price IS INITIAL
                                                    THEN if_abap_behv=>fc-o-disabled
                                                    ELSE if_abap_behv=>fc-o-enabled ) ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

  METHOD precheck_delete.
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

    RETURN.

  ENDMETHOD.

  METHOD SetReleaseDate.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( ReleaseDate ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(dates).

    DELETE dates WHERE ReleaseDate IS NOT INITIAL.

    IF dates IS NOT INITIAL.

      MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
             ENTITY Item
             UPDATE FIELDS ( ReleaseDate )
             WITH VALUE #( FOR date IN dates
                           ( %tky        = date-%tky
                             ReleaseDate = lv_date ) ).

      RETURN.

    ELSE.

      RETURN.

    ENDIF.

  ENDMETHOD.

  METHOD SetDiscontinueDate.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

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
             WITH VALUE #( FOR date IN dates
                         ( %tky            = date-%tky
                           DiscontinueDate = lv_date + 365 ) ).

      RETURN.

    ELSE.

      RETURN.

    ENDIF.

  ENDMETHOD.

  METHOD ValidateName.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
           ENTITY Item
           FIELDS ( Name ) WITH
           CORRESPONDING #( keys )
           RESULT DATA(Names).

    IF Names IS NOT INITIAL.

      LOOP AT Names ASSIGNING FIELD-SYMBOL(<fs_name>).

        IF <fs_name>-Name IS INITIAL.

          APPEND VALUE #( %tky = <fs_name>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky              = <fs_name>-%tky
*              %state_area       = 'VALIDATE_NAME'
              %element-name     = if_abap_behv=>mk-on
              %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_item_name
                                                           severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          CONTINUE.

        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.

  METHOD ValidatePrice.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( Price ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Prices).

    IF prices IS NOT INITIAL.

      LOOP AT Prices ASSIGNING FIELD-SYMBOL(<fs_price>).

        IF <fs_price>-price <= 0 OR <fs_price>-price IS INITIAL.

          APPEND VALUE #( %tky = <fs_price>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #( %tky           = <fs_price>-%tky
*                          %state_area       = 'VALIDATE_PRICE'
                          %element-price = if_abap_behv=>mk-on
                          %msg           = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_price
                                                                    severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          CONTINUE.

        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.

  METHOD validateCurrency.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( Currency ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Currencys).

    IF Currencys IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT Currencys ASSIGNING FIELD-SYMBOL(<fs_currency>).

      IF <fs_currency>-currency IS INITIAL.

        APPEND VALUE #( %tky = <fs_currency>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #( %tky              = <fs_currency>-%tky
*                        %state_area       = 'VALIDATE_CURRENCY'
                        %element-currency = if_abap_behv=>mk-on
                        %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_currency
                                                                     severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ELSE.

        CONTINUE.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.



  METHOD ValidateQuantity.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( Quantity ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(Quantitys).

    IF Quantitys IS NOT INITIAL.

      LOOP AT Quantitys ASSIGNING FIELD-SYMBOL(<fs_quantity>).

        IF <fs_quantity>-Quantity <= 0 OR <fs_quantity>-Quantity IS INITIAL.

          APPEND VALUE #( %tky = <fs_quantity>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky              = <fs_quantity>-%tky
*              %state_area       = 'VALIDATE_QUANTITY'
              %element-quantity = if_abap_behv=>mk-on
              %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_quantity
                                                           severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          CONTINUE.

        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.

  METHOD Discount.

    DATA Discounts TYPE TABLE FOR UPDATE zcds_r_item_0098.

    DATA price_discount TYPE zde_price_0098.
    DATA percentage     TYPE zde_price_0098.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Item
         FIELDS ( Price ) WITH
         CORRESPONDING #( keys )
         RESULT DATA(prices).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      IF <fs_key>-%param-Discount_percent <= 0 OR <fs_key>-%param-Discount_percent > 100.

        APPEND VALUE #( %tky = <fs_key>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #(
            %tky              = <fs_key>-%tky
*              %state_area       = 'VALIDATE_QUANTITY'
            %element-price = if_abap_behv=>mk-on
            %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_discount
                                                         severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ELSE.

        IF prices IS NOT INITIAL.

          percentage = keys[ KEY id %tky = <fs_key>-%tky ]-%param-Discount_percent.
          DATA(price) = prices[ KEY id %tky = <fs_key>-%tky ]-Price.

          percentage = percentage / 100.
          price_discount =  price * ( 1 - percentage ).

          APPEND VALUE #( %tky = <fs_key>-%tky
                          price = price_discount ) TO discounts.

          CONTINUE.

        ELSE.

          APPEND VALUE #( %tky = <fs_key>-%tky ) TO failed-item. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky              = <fs_key>-%tky
*              %state_area       = 'VALIDATE_QUANTITY'
              %element-price    = if_abap_behv=>mk-on
              %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>wrong_price
                                                           severity = if_abap_behv_message=>severity-error ) ) TO reported-item. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ENDIF.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
             ENTITY Item
             UPDATE FIELDS ( Price )
             WITH discounts.



  ENDMETHOD.

ENDCLASS.
