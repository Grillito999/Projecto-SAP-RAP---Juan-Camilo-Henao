@AccessControl.authorizationCheck: #NOT_REQUIRED // Sirve para restringir la autorizacón de la lectura de los datos (crear objeto access control).
@EndUserText.label: 'Root header - 0098'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCDS_R_HEADER_0098
  as select from zheader_0098
  composition [0..*] of ZCDS_R_ITEM_0098        as _Items
  association [0..1] to I_CountryVH             as _Country     on  $projection.Country = _Country.Description
                                                                and _Country.Country    = _Country.Country
  association [0..1] to ZCDS_OrderStatusVH_0098 as _orderStatus on  $projection.OrderStatus = _orderStatus.Orderstatus


{
  key id                    as HeaderUUID,
      header_id             as HeaderId,
      item_id               as ItemId,
      @Semantics.eMail.address: true
      email                 as Email,
      @Semantics.name.prefix: true
      first_name            as FirstName,
      @Semantics.name.suffix: true
      last_name             as LastName,
      @Semantics.address.country: true
      country               as Country,
      create_on             as CreateOn,
      delivery_date         as DeliveryDate,
      order_status          as OrderStatus,
      @Semantics.imageUrl: true
      image_url             as ImageUrl,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_at       as LastChangedAt,

      /* Associations */
      _Country,
      _orderStatus,
      _Items
}
