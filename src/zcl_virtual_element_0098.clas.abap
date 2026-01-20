CLASS zcl_virtual_element_0098 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_virtual_element_0098 IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    TRY.

        CASE iv_entity.

          WHEN 'ZCDS_C_ITEM_0098'.

            CONSTANTS C_PriceWithIVA TYPE c LENGTH 12 VALUE 'PRICEWITHIVA'.

            LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_virt_element>).

              IF <fs_virt_element> = C_PriceWithIVA.

                INSERT CONV #( 'PRICE' ) INTO TABLE et_requested_orig_elements.

              ENDIF.

            ENDLOOP.

          WHEN OTHERS.

            RETURN.

        ENDCASE.

      CATCH cx_sadl_exit INTO DATA(lo_sadl_error).

        lo_sadl_error->get_longtext(  ).

    ENDTRY.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.

    CONSTANTS c_iva TYPE p LENGTH 8 DECIMALS 2 VALUE '1.19'.

    DATA lt_original_data TYPE STANDARD TABLE OF zcds_c_item_0098 WITH DEFAULT KEY.

    TRY.

        lt_original_data = CORRESPONDING #( it_original_data ).

        LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_calc_iva>).

          <fs_calc_iva>-PriceWithIVA = <fs_calc_iva>-Price * c_iva.

        ENDLOOP.

        ct_calculated_data = CORRESPONDING #( lt_original_data ).

      CATCH cx_sadl_exit INTO DATA(lo_sadl_error).

        lo_sadl_error->get_longtext( ).

    ENDTRY.

  ENDMETHOD.



ENDCLASS.
