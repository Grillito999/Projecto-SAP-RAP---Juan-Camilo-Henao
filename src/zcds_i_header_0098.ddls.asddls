@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Root Header Interface - 0098'

@Metadata.ignorePropagatedAnnotations: true

define root view entity ZCDS_I_HEADER_0098
  provider contract transactional_interface
  as projection on ZCDS_R_HEADER_0098

{
  key HeaderUUID,

      HeaderId,
      ItemId,

      @Semantics.eMail.address: true
      Email,

      @Semantics.name.prefix: true
      FirstName,

      @Semantics.name.suffix: true
      LastName,

      @Semantics.address.country: true
      Country,

      CreateOn,
      DeliveryDate,
      OrderStatus,

      @Semantics.imageUrl: true
      ImageUrl,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Associations */
      _Items : redirected to composition child ZCDS_I_ITEMS_0098
}
