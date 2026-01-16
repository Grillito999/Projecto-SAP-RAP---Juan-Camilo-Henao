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

*/    METHODS ValidateCountry FOR VALIDATE ON SAVE
*/      IMPORTING keys FOR Header~ValidateCountry.

    METHODS ValidateDeliveryDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateDeliveryDate.

    METHODS ValidateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateEmail.

    METHODS ValidateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~ValidateName.

*    METHODS ValidateOrderStatus FOR VALIDATE ON SAVE
*      IMPORTING keys FOR Header~ValidateOrderStatus.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.
  METHOD get_instance_features.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( OrderStatus ) WITH CORRESPONDING #( keys )
         RESULT DATA(Status).

    result = VALUE #( FOR state IN Status
                      ( %tky                 = state-%tky
                        %action-ApproveOrder = COND #( WHEN state-OrderStatus = ty_order_status-approved
                                                       THEN if_abap_behv=>fc-o-disabled
                                                       ELSE if_abap_behv=>fc-o-enabled )

                        %action-RejectOrder  = COND #( WHEN state-OrderStatus = ty_order_status-rejeccted
                                                       THEN if_abap_behv=>fc-o-disabled
                                                       WHEN state-OrderStatus = ty_order_status-approved
                                                       THEN if_abap_behv=>fc-o-disabled
                                                       ELSE if_abap_behv=>fc-o-enabled )

                        %assoc-_Items        = COND #( WHEN state-OrderStatus = ty_order_status-approved
                                                       THEN if_abap_behv=>fc-o-disabled
                                                       ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.

    DATA Header TYPE SORTED TABLE OF zcds_r_header_0098 WITH UNIQUE KEY HeaderUUID.

    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).
    DATA lv_auth_update TYPE abap_boolean.
    DATA lv_auth_delete TYPE abap_boolean.

    CONSTANTS C_header TYPE n LENGTH 1 VALUE 1.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId ) WITH CORRESPONDING #( keys )
         RESULT DATA(Headers).

    Header = CORRESPONDING #( Headers DISCARDING DUPLICATES MAPPING HeaderUUID = HeaderUUID HeaderId = HeaderId EXCEPT * ).

    LOOP AT Headers ASSIGNING FIELD-SYMBOL(<fs_header>).

      IF line_exists( Header[ HeaderUUID = <fs_header>-HeaderUUID
                              HeaderId   = <fs_header>-HeaderId ] ) AND lv_technical_name = 'CB9980002241' AND <fs_header>-HeaderId <> C_header.

        IF requested_authorizations-%update = if_abap_behv=>mk-on OR requested_authorizations-%action-Edit = if_abap_behv=>mk-on AND requested_authorizations-%delete = if_abap_behv=>mk-on.

          lv_auth_delete = abap_true.
          lv_auth_update = abap_true.

        ELSEIF requested_authorizations-%update = if_abap_behv=>mk-on OR requested_authorizations-%action-Edit = if_abap_behv=>mk-on.

          lv_auth_update = abap_true.

        ELSEIF requested_authorizations-%delete = if_abap_behv=>mk-on.

          lv_auth_delete = abap_true.

        ELSE.

          APPEND VALUE #( %tky = <fs_header>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky              = <fs_header>-%tky
*                        %state_area       = 'INSTANCE_AUTH'
              %element-HeaderId = if_abap_behv=>mk-on
              %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>not_authorized
                                                           severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ENDIF.

      ENDIF.

      APPEND VALUE #( LET auth_update = COND #( WHEN lv_auth_update = abap_true
                                                THEN if_abap_behv=>auth-allowed
                                                ELSE if_abap_behv=>auth-unauthorized )

                          auth_delete = COND #( WHEN lv_auth_delete = abap_true
                                                THEN if_abap_behv=>auth-allowed
                                                ELSE if_abap_behv=>auth-unauthorized ) IN
                      %tky         = <fs_header>-%tky
                      %update      = auth_update
                      %action-edit = auth_update
                      %delete      = auth_delete ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.

    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    IF requested_authorizations-%create = if_abap_behv=>mk-on.

      IF lv_technical_name = 'CB9980002241'.

        result-%create = if_abap_behv=>auth-allowed.

      ELSE.

        result-%create = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg    = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>not_authorized
                                                           severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on    ) TO reported-header.

      ENDIF.

    ELSEIF requested_authorizations-%update = if_abap_behv=>mk-on OR requested_authorizations-%action-Edit = if_abap_behv=>mk-on.

      IF lv_technical_name = 'CB9980002241'.

        result-%update      = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.

      ELSE.

        result-%update      = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg    = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>not_authorized
                                                           severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on                                 ) TO reported-header.

      ENDIF.

    ELSEIF requested_authorizations-%delete = if_abap_behv=>mk-on.

      IF lv_technical_name = 'CB9980002241'.

        result-%delete = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg    = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>not_authorized
                                                           severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on                                 ) TO reported-header.

      ELSE.

        result-%delete = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg    = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>not_authorized
                                                           severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on                                 ) TO reported-header.

      ENDIF.

    ELSE.

      RETURN.

    ENDIF.

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
         FIELDS ( OrderStatus ) WITH CORRESPONDING #( keys )
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
         FIELDS ( OrderStatus ) WITH CORRESPONDING #( keys )
         RESULT DATA(Headers).

    result = VALUE #( FOR Header IN Headers
                      ( %tky   = Header-%tky
                        %param = header ) ).

  ENDMETHOD.

  METHOD SetHeaderID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId ) WITH CORRESPONDING #( keys )
         RESULT DATA(Headers).

    DELETE headers WHERE HeaderId IS NOT INITIAL.

    CHECK headers IS NOT INITIAL.

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

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
          ENTITY Header
          FIELDS ( OrderStatus ) WITH CORRESPONDING #( keys )
          RESULT DATA(Orders).

    DELETE Orders WHERE OrderStatus IS NOT INITIAL.

    CHECK orders IS NOT INITIAL.

    MODIFY ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
             ENTITY Header
             UPDATE FIELDS ( OrderStatus )
             WITH VALUE #( FOR order IN keys
                           ( %tky        = order-%tky
                             OrderStatus = ty_order_status-open  ) ).

  ENDMETHOD.

*/ METHOD ValidateCountry.
*/  ENDMETHOD.

  METHOD ValidateDeliveryDate.

    DATA Date TYPE SORTED TABLE OF zcds_r_header_0098 WITH UNIQUE KEY HeaderUUID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( DeliveryDate CreateOn ) WITH CORRESPONDING #( keys )
         RESULT DATA(Orders).

    Date = CORRESPONDING #( Orders DISCARDING DUPLICATES MAPPING HeaderUUID = HeaderUUID DeliveryDate = DeliveryDate CreateOn = CreateOn EXCEPT * ).

    LOOP AT Orders ASSIGNING FIELD-SYMBOL(<fs_order>).

      IF line_exists( date[ HeaderUUID = <fs_order>-HeaderUUID ] ).

        IF <fs_order>-DeliveryDate IS INITIAL OR <fs_order>-CreateOn IS INITIAL.

          APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky                  = <fs_order>-%tky
              %state_area           = 'VALIDATE_DELIVERY'
              %element-DeliveryDate = if_abap_behv=>mk-on
              %msg                  = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>enter_delivery_date
                                                               severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSEIF <fs_order>-DeliveryDate < <fs_order>-CreateOn.

          APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #(
              %tky                  = <fs_order>-%tky
              %state_area           = 'VALIDATE_DELIVERY'
              %element-DeliveryDate = if_abap_behv=>mk-on
              %msg                  = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>Invalid_date
                                                               severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          RETURN.

        ENDIF.

      ELSE.

        APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #(
            %tky                  = <fs_order>-%tky
            %state_area           = 'VALIDATE_DELIVERY'
            %element-DeliveryDate = if_abap_behv=>mk-on
            %msg                  = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>enter_delivery_date
                                                             severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateEmail.

    DATA Email TYPE SORTED TABLE OF zcds_r_header_0098 WITH UNIQUE KEY HeaderUUID.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( Email ) WITH CORRESPONDING #( keys )
         RESULT DATA(Orders).

    Email = CORRESPONDING #( Orders DISCARDING DUPLICATES MAPPING HeaderUUID = HeaderUUID Email = Email EXCEPT * ).

    LOOP AT Orders ASSIGNING FIELD-SYMBOL(<fs_order>).

      IF line_exists( Email[ HeaderUUID = <fs_order>-HeaderUUID ] ).

        IF <fs_order>-Email IS INITIAL.

          APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
          APPEND VALUE #( %tky           = <fs_order>-%tky
                          %state_area    = 'VALIDATE_EMAIL'
                          %element-Email = if_abap_behv=>mk-on
                          %msg           = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_email
                                                                    severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

        ELSE.

          RETURN.

        ENDIF.

      ELSE.

        APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #( %tky           = <fs_order>-%tky
                        %state_area    = 'VALIDATE_EMAIL'
                        %element-Email = if_abap_behv=>mk-on
                        %msg           = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_email
                                                                  severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateName.
    DATA Names TYPE SORTED TABLE OF zcds_r_header_0098 WITH UNIQUE KEY HeaderUUID.

    CONSTANTS C_Numbers TYPE n LENGTH 10 VALUE '0123456789'.

    READ ENTITIES OF zcds_r_header_0098 IN LOCAL MODE
         ENTITY Header
         FIELDS ( FirstName LastName ) WITH CORRESPONDING #( keys )
         RESULT DATA(Orders).

    Names = CORRESPONDING #( Orders DISCARDING DUPLICATES MAPPING HeaderUUID = HeaderUUID FirstName = FirstName LastName = LastName EXCEPT * ).

    LOOP AT Orders ASSIGNING FIELD-SYMBOL(<fs_order>).

      IF NOT line_exists( Names[ HeaderUUID = <fs_order>-HeaderUUID ] ).
        CONTINUE.
      ENDIF.

      IF <fs_order>-FirstName IS NOT INITIAL AND <fs_order>-FirstName CA c_numbers.

        APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #(
            %tky               = <fs_order>-%tky
            %state_area        = 'VALIDATE_NAME'
            %element-FirstName = if_abap_behv=>mk-on
            %msg               = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_first_name
                                                          severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ELSEIF <fs_order>-LastName IS NOT INITIAL AND <fs_order>-LastName CA c_numbers.

        APPEND VALUE #( %tky = <fs_order>-%tky ) TO failed-header. " FAILED es para que SAP identifique el error, unicamente se le pasa la llave "
        APPEND VALUE #( %tky              = <fs_order>-%tky
                        %state_area       = 'VALIDATE_NAME'
                        %element-LastName = if_abap_behv=>mk-on
                        %msg              = NEW zcm_sale_order_0098( textid   = zcm_sale_order_0098=>invalid_last_name
                                                                     severity = if_abap_behv_message=>severity-error ) ) TO reported-header. " REPORTED es para que el USUARIO vea el error, tiene distintos parametros.

      ELSE.

        EXIT.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

*  METHOD ValidateOrderStatus.
*  ENDMETHOD.

ENDCLASS.
