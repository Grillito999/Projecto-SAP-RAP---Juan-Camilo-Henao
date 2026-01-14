CLASS zcm_sale_order_0098 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    CONSTANTS gc_msgid TYPE symsgid VALUE 'ZCM_SALE_ORDER_0098'.

    CONSTANTS: BEGIN OF enter_delivery_date,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '001',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF enter_delivery_date.

    CONSTANTS: BEGIN OF invalid_date,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '002',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_date.

    CONSTANTS: BEGIN OF invalid_email,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '003',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_email.

    CONSTANTS: BEGIN OF invalid_first_name,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '004',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_first_name.

    CONSTANTS: BEGIN OF invalid_last_name,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '005',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_last_name.

    CONSTANTS: BEGIN OF not_authorized,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '006',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF not_authorized.

    CONSTANTS: BEGIN OF wrong_price,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '007',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF wrong_price.

    CONSTANTS: BEGIN OF wrong_quantity,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '008',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF wrong_quantity.

    CONSTANTS: BEGIN OF wrong_currency,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '009',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF wrong_currency.

    CONSTANTS: BEGIN OF invalid_item_name,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '010',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_item_name.

    CONSTANTS: BEGIN OF invalid_discount,
                 msgid TYPE symsgid      VALUE 'ZCM_SALE_ORDER_0098',
                 msgno TYPE symsgno      VALUE '011',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_discount.

    METHODS constructor
      IMPORTING textid        LIKE if_t100_message=>t100key         OPTIONAL
                !previous     LIKE previous                         OPTIONAL
                severity      TYPE if_abap_behv_message=>t_severity OPTIONAL
                attr1         TYPE string                           OPTIONAL
                attr2         TYPE string                           OPTIONAL
                attr3         TYPE string                           OPTIONAL
                attr4         TYPE string                           OPTIONAL
                delivery_date TYPE zde_delivery_date_0098           OPTIONAL
                first_name    TYPE zde_email_0098                   OPTIONAL
                last_name     TYPE zde_first_name_0098              OPTIONAL
                price         TYPE zde_price_0098                   OPTIONAL
                email         TYPE zde_last_name_0098               OPTIONAL
                currency      TYPE zde_quantity_0098                OPTIONAL
                quantity      TYPE zde_quantity_0098                OPTIONAL
                item_name     TYPE zde_name_0098                    OPTIONAL
                discount      TYPE zde_price_0098                   OPTIONAL.

    DATA mv_attr1         TYPE string.
    DATA mv_attr2         TYPE string.
    DATA mv_attr3         TYPE string.
    DATA mv_attr4         TYPE string.
*    DATA mv_delivery_date TYPE zde_delivery_date_0098.
*    DATA mv_email         TYPE zde_email_0098.
*    DATA mv_first_name    TYPE zde_first_name_0098.
*    DATA mv_last_name     TYPE zde_last_name_0098.
*    DATA mv_price         TYPE zde_price_0098.
*    DATA mv_quantity      TYPE zde_quantity_0098.
*    DATA mv_currency      TYPE zde_currency_0098.
*    DATA mv_item_name     TYPE zde_name_0098.
*    DATA mv_discount      TYPE zde_price_0098.

PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_sale_order_0098 IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    mv_attr1         = attr1.
    mv_attr2         = attr2.
    mv_attr3         = attr3.
    mv_attr4         = attr4.
*    mv_delivery_date = delivery_date.
*    mv_email         = email.
*    mv_first_name    = first_name.
*    mv_last_name     = last_name.
*    mv_price         = price.
*    mv_quantity      = quantity.
*    mv_quantity      = currency.
*    mv_item_name     = item_name.
*    mv_discount      = discount.

    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
